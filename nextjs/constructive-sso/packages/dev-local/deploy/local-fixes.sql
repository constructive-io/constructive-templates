-- Deploy: local-fixes
-- Phase 1a item #5: port validator fix from constructive-db commit 5a35b43773
-- 'Allow membership_types-only blueprints (validator fix)'
-- Allows tables:[] + membership_types[]-only blueprints (e.g. data-room).

-- Deploy schemas/metaschema_modules_public/procedures/validate_blueprint_definition/procedure to pg

-- No requires: dev-local patches a running DB directly
-- (schemas/tables already exist from constructive-local deploy)

BEGIN;

-- Trigger function that validates the blueprint definition format.
-- Enforces structural correctness on INSERT/UPDATE of blueprint and blueprint_template.
-- Validates:
--   1. tables[] is a non-empty array with required keys (table_name, nodes[])
--   2. nodes[] entries are strings or {"$type": "...", "data": {...}} objects
--   3. policies[] entries have $type
--   4. relations[] entries have $type, source_table, target_table
--   5. indexes[] entries have table_name, column, access_method (top-level) or column, access_method (table-level)
--   6. full_text_searches[] entries have table_name, field, sources[] (top-level) or field, sources[] (table-level)
--   7. unique_constraints[] entries have table_name, columns[] (top-level) or columns[] (table-level)
--   8. Table-level indexes[], full_text_searches[], unique_constraints[] are also validated (table_name not required)
CREATE OR REPLACE FUNCTION metaschema_modules_public.tg_validate_blueprint_definition()
RETURNS TRIGGER AS $$
DECLARE
    v_definition jsonb;
    v_table_entry jsonb;
    v_table_idx integer;
    v_node_entry jsonb;
    v_node_idx integer;
    v_policy_entry jsonb;
    v_policy_idx integer;
    v_relation_entry jsonb;
    v_relation_idx integer;
    v_table_name text;
    v_mt_entry jsonb;
    v_mt_idx integer;
    v_index_entry jsonb;
    v_index_idx integer;
    v_fts_entry jsonb;
    v_fts_idx integer;
    v_source_entry jsonb;
    v_source_idx integer;
    v_uniq_entry jsonb;
    v_uniq_idx integer;

    -- Table-level nested validation
    v_tbl_index_entry jsonb;
    v_tbl_index_idx integer;
    v_tbl_fts_entry jsonb;
    v_tbl_fts_idx integer;
    v_tbl_fts_source_entry jsonb;
    v_tbl_fts_source_idx integer;
    v_tbl_uniq_entry jsonb;
    v_tbl_uniq_idx integer;
BEGIN
    v_definition := NEW.definition;

    -- definition must be an object
    IF jsonb_typeof(v_definition) != 'object' THEN
        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: definition must be a JSON object, got %', jsonb_typeof(v_definition);
    END IF;

    -- tables[] is required and must be an array
    IF NOT (v_definition ? 'tables') THEN
        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: definition must contain a "tables" array';
    END IF;

    IF jsonb_typeof(v_definition->'tables') != 'array' THEN
        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "tables" must be an array, got %', jsonb_typeof(v_definition->'tables');
    END IF;

    -- An empty tables[] is allowed for metadata-only blueprints (e.g. cross-relations,
    -- spatial-relations, membership-only data rooms) that declare relations / indexes /
    -- full_text_searches / unique_constraints over already-provisioned tables, or
    -- declare new entity_types[] / membership_types[] (which provision their own entity
    -- + storage tables via the entity_type pipeline). At least one of those collections
    -- must contain entries for the blueprint to be meaningful.
    IF jsonb_array_length(v_definition->'tables') = 0 THEN
        IF COALESCE(jsonb_array_length(v_definition->'relations'), 0) = 0
           AND COALESCE(jsonb_array_length(v_definition->'indexes'), 0) = 0
           AND COALESCE(jsonb_array_length(v_definition->'full_text_searches'), 0) = 0
           AND COALESCE(jsonb_array_length(v_definition->'unique_constraints'), 0) = 0
           AND COALESCE(jsonb_array_length(v_definition->'membership_types'), 0) = 0
           AND COALESCE(jsonb_array_length(v_definition->'entity_types'), 0) = 0
        THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "tables" array must not be empty (or provide at least one of relations/indexes/full_text_searches/unique_constraints/membership_types/entity_types)';
        END IF;
    END IF;

    -- Validate membership_types[] if present (optional)
    -- Also validate entity_types[] — the server-side construct_blueprint()
    -- accepts both keys interchangeably.
    IF v_definition ? 'entity_types' THEN
        -- Treat entity_types the same as membership_types for validation
        IF jsonb_typeof(v_definition->'entity_types') != 'array' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "entity_types" must be an array, got %', jsonb_typeof(v_definition->'entity_types');
        END IF;

        v_mt_idx := 0;
        FOR v_mt_entry IN SELECT jsonb_array_elements(v_definition->'entity_types') LOOP

            IF jsonb_typeof(v_mt_entry) != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] must be an object', v_mt_idx;
            END IF;

            -- Required keys: name, prefix
            IF NOT (v_mt_entry ? 'name') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] missing required key "name"', v_mt_idx;
            END IF;

            IF NOT (v_mt_entry ? 'prefix') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] missing required key "prefix"', v_mt_idx;
            END IF;

            -- Optional string keys
            IF v_mt_entry ? 'description' AND jsonb_typeof(v_mt_entry->'description') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "description" must be a string', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'parent_entity' AND jsonb_typeof(v_mt_entry->'parent_entity') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "parent_entity" must be a string', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'table_name' AND jsonb_typeof(v_mt_entry->'table_name') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_name" must be a string', v_mt_idx;
            END IF;

            -- Optional boolean keys
            IF v_mt_entry ? 'is_visible' AND jsonb_typeof(v_mt_entry->'is_visible') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "is_visible" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_limits' AND jsonb_typeof(v_mt_entry->'has_limits') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "has_limits" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_profiles' AND jsonb_typeof(v_mt_entry->'has_profiles') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "has_profiles" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_levels' AND jsonb_typeof(v_mt_entry->'has_levels') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "has_levels" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_storage' AND jsonb_typeof(v_mt_entry->'has_storage') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "has_storage" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_invites' AND jsonb_typeof(v_mt_entry->'has_invites') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "has_invites" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'skip_entity_policies' AND jsonb_typeof(v_mt_entry->'skip_entity_policies') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "skip_entity_policies" must be a boolean', v_mt_idx;
            END IF;

            -- storage validation (same as membership_types)
            IF v_mt_entry ? 'storage' THEN
                IF jsonb_typeof(v_mt_entry->'storage') != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage" must be an object', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'upload_url_expiry_seconds'
                   AND jsonb_typeof(v_mt_entry->'storage'->'upload_url_expiry_seconds') != 'number' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.upload_url_expiry_seconds" must be a number', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'download_url_expiry_seconds'
                   AND jsonb_typeof(v_mt_entry->'storage'->'download_url_expiry_seconds') != 'number' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.download_url_expiry_seconds" must be a number', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'default_max_file_size'
                   AND jsonb_typeof(v_mt_entry->'storage'->'default_max_file_size') != 'number' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.default_max_file_size" must be a number', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'allowed_origins'
                   AND jsonb_typeof(v_mt_entry->'storage'->'allowed_origins') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.allowed_origins" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'buckets' THEN
                    IF jsonb_typeof(v_mt_entry->'storage'->'buckets') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.buckets" must be an array', v_mt_idx;
                    END IF;

                    IF EXISTS (
                        SELECT 1
                        FROM jsonb_array_elements(v_mt_entry->'storage'->'buckets') AS b
                        WHERE jsonb_typeof(b) != 'object' OR NOT (b ? 'name')
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.buckets[]" entries must be objects with "name"', v_mt_idx;
                    END IF;
                END IF;

                IF v_mt_entry->'storage' ? 'files_nodes' THEN
                    IF jsonb_typeof(v_mt_entry->'storage'->'files_nodes') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.files_nodes" must be an array', v_mt_idx;
                    END IF;
                    IF EXISTS (
                        SELECT 1 FROM jsonb_array_elements(v_mt_entry->'storage'->'files_nodes') AS n
                        WHERE jsonb_typeof(n) != 'object'
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.files_nodes[]" entries must be objects', v_mt_idx;
                    END IF;
                END IF;

                IF v_mt_entry->'storage' ? 'files_fields' THEN
                    IF jsonb_typeof(v_mt_entry->'storage'->'files_fields') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.files_fields" must be an array', v_mt_idx;
                    END IF;
                    IF EXISTS (
                        SELECT 1 FROM jsonb_array_elements(v_mt_entry->'storage'->'files_fields') AS f
                        WHERE jsonb_typeof(f) != 'object' OR NOT (f ? 'name')
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "storage.files_fields[]" entries must be objects with "name"', v_mt_idx;
                    END IF;
                END IF;
            END IF;

            -- table_provision validation (same as membership_types)
            IF v_mt_entry ? 'table_provision' THEN
                IF jsonb_typeof(v_mt_entry->'table_provision') != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision" must be an object', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'policies' THEN
                    IF jsonb_typeof(v_mt_entry->'table_provision'->'policies') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision.policies" must be an array', v_mt_idx;
                    END IF;

                    IF EXISTS (
                        SELECT 1
                        FROM jsonb_array_elements(v_mt_entry->'table_provision'->'policies') AS p
                        WHERE jsonb_typeof(p) != 'object' OR NOT (p ? '$type')
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision.policies[]" entries must be objects with "$type"', v_mt_idx;
                    END IF;
                END IF;

                IF v_mt_entry->'table_provision' ? 'nodes'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'nodes') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision.nodes" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'fields'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'fields') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision.fields" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'grants'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'grants') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision.grants" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'use_rls'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'use_rls') != 'boolean' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: entity_types[%] "table_provision.use_rls" must be a boolean', v_mt_idx;
                END IF;
            END IF;

            v_mt_idx := v_mt_idx + 1;
        END LOOP;
    END IF;

    -- Validate membership_types[] if present (optional)
    IF v_definition ? 'membership_types' THEN
        IF jsonb_typeof(v_definition->'membership_types') != 'array' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "membership_types" must be an array, got %', jsonb_typeof(v_definition->'membership_types');
        END IF;

        v_mt_idx := 0;
        FOR v_mt_entry IN SELECT jsonb_array_elements(v_definition->'membership_types') LOOP

            IF jsonb_typeof(v_mt_entry) != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] must be an object', v_mt_idx;
            END IF;

            -- Required keys: name, prefix
            IF NOT (v_mt_entry ? 'name') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] missing required key "name"', v_mt_idx;
            END IF;

            IF NOT (v_mt_entry ? 'prefix') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] missing required key "prefix"', v_mt_idx;
            END IF;

            -- Optional string keys
            IF v_mt_entry ? 'description' AND jsonb_typeof(v_mt_entry->'description') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "description" must be a string', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'parent_entity' AND jsonb_typeof(v_mt_entry->'parent_entity') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "parent_entity" must be a string', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'table_name' AND jsonb_typeof(v_mt_entry->'table_name') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_name" must be a string', v_mt_idx;
            END IF;

            -- Optional boolean keys
            IF v_mt_entry ? 'is_visible' AND jsonb_typeof(v_mt_entry->'is_visible') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "is_visible" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_limits' AND jsonb_typeof(v_mt_entry->'has_limits') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "has_limits" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_profiles' AND jsonb_typeof(v_mt_entry->'has_profiles') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "has_profiles" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_levels' AND jsonb_typeof(v_mt_entry->'has_levels') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "has_levels" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_storage' AND jsonb_typeof(v_mt_entry->'has_storage') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "has_storage" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'has_invites' AND jsonb_typeof(v_mt_entry->'has_invites') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "has_invites" must be a boolean', v_mt_idx;
            END IF;

            IF v_mt_entry ? 'skip_entity_policies' AND jsonb_typeof(v_mt_entry->'skip_entity_policies') != 'boolean' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "skip_entity_policies" must be a boolean', v_mt_idx;
            END IF;

            -- storage is optional. When present it must be a jsonb object with known keys:
            -- upload_url_expiry_seconds (number), download_url_expiry_seconds (number),
            -- default_max_file_size (number), allowed_origins (array of strings),
            -- buckets (array of bucket definitions). Each bucket must have a "name" key.
            IF v_mt_entry ? 'storage' THEN
                IF jsonb_typeof(v_mt_entry->'storage') != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage" must be an object', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'upload_url_expiry_seconds'
                   AND jsonb_typeof(v_mt_entry->'storage'->'upload_url_expiry_seconds') != 'number' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.upload_url_expiry_seconds" must be a number', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'download_url_expiry_seconds'
                   AND jsonb_typeof(v_mt_entry->'storage'->'download_url_expiry_seconds') != 'number' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.download_url_expiry_seconds" must be a number', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'default_max_file_size'
                   AND jsonb_typeof(v_mt_entry->'storage'->'default_max_file_size') != 'number' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.default_max_file_size" must be a number', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'allowed_origins'
                   AND jsonb_typeof(v_mt_entry->'storage'->'allowed_origins') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.allowed_origins" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'storage' ? 'buckets' THEN
                    IF jsonb_typeof(v_mt_entry->'storage'->'buckets') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.buckets" must be an array', v_mt_idx;
                    END IF;

                    IF EXISTS (
                        SELECT 1
                        FROM jsonb_array_elements(v_mt_entry->'storage'->'buckets') AS b
                        WHERE jsonb_typeof(b) != 'object' OR NOT (b ? 'name')
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.buckets[]" entries must be objects with "name"', v_mt_idx;
                    END IF;
                END IF;

                IF v_mt_entry->'storage' ? 'files_nodes' THEN
                    IF jsonb_typeof(v_mt_entry->'storage'->'files_nodes') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.files_nodes" must be an array', v_mt_idx;
                    END IF;
                    IF EXISTS (
                        SELECT 1 FROM jsonb_array_elements(v_mt_entry->'storage'->'files_nodes') AS n
                        WHERE jsonb_typeof(n) != 'object'
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.files_nodes[]" entries must be objects', v_mt_idx;
                    END IF;
                END IF;

                IF v_mt_entry->'storage' ? 'files_fields' THEN
                    IF jsonb_typeof(v_mt_entry->'storage'->'files_fields') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.files_fields" must be an array', v_mt_idx;
                    END IF;
                    IF EXISTS (
                        SELECT 1 FROM jsonb_array_elements(v_mt_entry->'storage'->'files_fields') AS f
                        WHERE jsonb_typeof(f) != 'object' OR NOT (f ? 'name')
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "storage.files_fields[]" entries must be objects with "name"', v_mt_idx;
                    END IF;
                END IF;
            END IF;

            -- table_provision is optional. When present it must be a single jsonb object
            -- using the same shape as blueprint tables[] entries (policies[], nodes[],
            -- fields[], grants[], use_rls). The entity_type_provision trigger forwards
            -- it as a single secure_table_provision row (auto-filling database_id and
            -- table_id). Its presence replaces the five default entity-table policies.
            IF v_mt_entry ? 'table_provision' THEN
                IF jsonb_typeof(v_mt_entry->'table_provision') != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision" must be an object', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'policies' THEN
                    IF jsonb_typeof(v_mt_entry->'table_provision'->'policies') != 'array' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision.policies" must be an array', v_mt_idx;
                    END IF;

                    IF EXISTS (
                        SELECT 1
                        FROM jsonb_array_elements(v_mt_entry->'table_provision'->'policies') AS p
                        WHERE jsonb_typeof(p) != 'object' OR NOT (p ? '$type')
                    ) THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision.policies[]" entries must be objects with "$type"', v_mt_idx;
                    END IF;
                END IF;

                IF v_mt_entry->'table_provision' ? 'nodes'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'nodes') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision.nodes" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'fields'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'fields') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision.fields" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'grants'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'grants') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision.grants" must be an array', v_mt_idx;
                END IF;

                IF v_mt_entry->'table_provision' ? 'use_rls'
                   AND jsonb_typeof(v_mt_entry->'table_provision'->'use_rls') != 'boolean' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: membership_types[%] "table_provision.use_rls" must be a boolean', v_mt_idx;
                END IF;
            END IF;

            v_mt_idx := v_mt_idx + 1;
        END LOOP;
    END IF;

    -- Validate each table entry
    v_table_idx := 0;
    FOR v_table_entry IN SELECT jsonb_array_elements(v_definition->'tables') LOOP

        IF jsonb_typeof(v_table_entry) != 'object' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] must be an object', v_table_idx;
        END IF;

        v_table_name := COALESCE(v_table_entry->>'table_name', 'index ' || v_table_idx);

        -- Required key: table_name
        IF NOT (v_table_entry ? 'table_name') THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] missing required key "table_name"', v_table_idx;
        END IF;

        -- nodes[] is optional but if present must be a non-empty array
        IF v_table_entry ? 'nodes' THEN
            IF jsonb_typeof(v_table_entry->'nodes') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "nodes" must be an array', v_table_idx, v_table_name;
            END IF;

            IF jsonb_array_length(v_table_entry->'nodes') = 0 THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "nodes" array must not be empty', v_table_idx, v_table_name;
            END IF;

            -- Validate each node entry
            v_node_idx := 0;
            WHILE v_node_idx < jsonb_array_length(v_table_entry->'nodes') LOOP
                v_node_entry := v_table_entry->'nodes'->v_node_idx;

                IF jsonb_typeof(v_node_entry) = 'string' THEN
                    -- String shorthand: valid (e.g. "DataTimestamps")
                    NULL;
                ELSIF jsonb_typeof(v_node_entry) = 'object' THEN
                    -- Object form: must have $type
                    IF NOT (v_node_entry ? '$type') THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) nodes[%] object missing required key "$type"', v_table_idx, v_table_name, v_node_idx;
                    END IF;
                    -- data key is optional, but if present must be an object
                    IF v_node_entry ? 'data' AND jsonb_typeof(v_node_entry->'data') != 'object' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) nodes[%] "data" must be an object', v_table_idx, v_table_name, v_node_idx;
                    END IF;
                ELSE
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) nodes[%] must be a string or object, got %', v_table_idx, v_table_name, v_node_idx, jsonb_typeof(v_node_entry);
                END IF;

                v_node_idx := v_node_idx + 1;
            END LOOP;
        END IF;

        -- Validate policies[] if present
        IF v_table_entry ? 'policies' THEN
            IF jsonb_typeof(v_table_entry->'policies') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "policies" must be an array', v_table_idx, v_table_name;
            END IF;

            v_policy_idx := 0;
            WHILE v_policy_idx < jsonb_array_length(v_table_entry->'policies') LOOP
                v_policy_entry := v_table_entry->'policies'->v_policy_idx;

                IF jsonb_typeof(v_policy_entry) != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) policies[%] must be an object', v_table_idx, v_table_name, v_policy_idx;
                END IF;

                IF NOT (v_policy_entry ? '$type') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) policies[%] missing required key "$type"', v_table_idx, v_table_name, v_policy_idx;
                END IF;

                -- data key is optional, but if present must be an object
                IF v_policy_entry ? 'data' AND jsonb_typeof(v_policy_entry->'data') != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) policies[%] "data" must be an object', v_table_idx, v_table_name, v_policy_idx;
                END IF;

                v_policy_idx := v_policy_idx + 1;
            END LOOP;
        END IF;

        -- Validate grants[] if present
        IF v_table_entry ? 'grants' THEN
            IF jsonb_typeof(v_table_entry->'grants') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "grants" must be an array', v_table_idx, v_table_name;
            END IF;
        END IF;

        -- schema_name is optional but if present must be a string
        IF v_table_entry ? 'schema_name' AND jsonb_typeof(v_table_entry->'schema_name') != 'string' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "schema_name" must be a string', v_table_idx, v_table_name;
        END IF;

        -- Validate table-level indexes[] if present (table_name not required)
        IF v_table_entry ? 'indexes' THEN
            IF jsonb_typeof(v_table_entry->'indexes') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "indexes" must be an array', v_table_idx, v_table_name;
            END IF;

            v_tbl_index_idx := 0;
            FOR v_tbl_index_entry IN SELECT jsonb_array_elements(v_table_entry->'indexes') LOOP
                IF jsonb_typeof(v_tbl_index_entry) != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) indexes[%] must be an object', v_table_idx, v_table_name, v_tbl_index_idx;
                END IF;

                IF NOT (v_tbl_index_entry ? 'column') AND NOT (v_tbl_index_entry ? 'columns') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) indexes[%] missing required key "column" (or "columns")', v_table_idx, v_table_name, v_tbl_index_idx;
                END IF;

                IF v_tbl_index_entry ? 'columns' AND jsonb_typeof(v_tbl_index_entry->'columns') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) indexes[%] "columns" must be an array', v_table_idx, v_table_name, v_tbl_index_idx;
                END IF;

                IF NOT (v_tbl_index_entry ? 'access_method') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) indexes[%] missing required key "access_method"', v_table_idx, v_table_name, v_tbl_index_idx;
                END IF;

                IF v_tbl_index_entry ? 'options' AND jsonb_typeof(v_tbl_index_entry->'options') != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) indexes[%] "options" must be an object', v_table_idx, v_table_name, v_tbl_index_idx;
                END IF;

                IF v_tbl_index_entry ? 'op_classes' AND jsonb_typeof(v_tbl_index_entry->'op_classes') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) indexes[%] "op_classes" must be an array', v_table_idx, v_table_name, v_tbl_index_idx;
                END IF;

                v_tbl_index_idx := v_tbl_index_idx + 1;
            END LOOP;
        END IF;

        -- Validate table-level full_text_searches[] if present (table_name not required)
        IF v_table_entry ? 'full_text_searches' THEN
            IF jsonb_typeof(v_table_entry->'full_text_searches') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "full_text_searches" must be an array', v_table_idx, v_table_name;
            END IF;

            v_tbl_fts_idx := 0;
            FOR v_tbl_fts_entry IN SELECT jsonb_array_elements(v_table_entry->'full_text_searches') LOOP
                IF jsonb_typeof(v_tbl_fts_entry) != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] must be an object', v_table_idx, v_table_name, v_tbl_fts_idx;
                END IF;

                IF NOT (v_tbl_fts_entry ? 'field') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] missing required key "field"', v_table_idx, v_table_name, v_tbl_fts_idx;
                END IF;

                IF NOT (v_tbl_fts_entry ? 'sources') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] missing required key "sources"', v_table_idx, v_table_name, v_tbl_fts_idx;
                END IF;

                IF jsonb_typeof(v_tbl_fts_entry->'sources') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] "sources" must be an array', v_table_idx, v_table_name, v_tbl_fts_idx;
                END IF;

                IF jsonb_array_length(v_tbl_fts_entry->'sources') = 0 THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] "sources" must not be empty', v_table_idx, v_table_name, v_tbl_fts_idx;
                END IF;

                v_tbl_fts_source_idx := 0;
                WHILE v_tbl_fts_source_idx < jsonb_array_length(v_tbl_fts_entry->'sources') LOOP
                    v_tbl_fts_source_entry := v_tbl_fts_entry->'sources'->v_tbl_fts_source_idx;

                    IF jsonb_typeof(v_tbl_fts_source_entry) != 'object' THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] sources[%] must be an object', v_table_idx, v_table_name, v_tbl_fts_idx, v_tbl_fts_source_idx;
                    END IF;

                    IF NOT (v_tbl_fts_source_entry ? 'field') THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] sources[%] missing "field"', v_table_idx, v_table_name, v_tbl_fts_idx, v_tbl_fts_source_idx;
                    END IF;

                    IF NOT (v_tbl_fts_source_entry ? 'weight') THEN
                        RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) full_text_searches[%] sources[%] missing "weight"', v_table_idx, v_table_name, v_tbl_fts_idx, v_tbl_fts_source_idx;
                    END IF;

                    v_tbl_fts_source_idx := v_tbl_fts_source_idx + 1;
                END LOOP;

                v_tbl_fts_idx := v_tbl_fts_idx + 1;
            END LOOP;
        END IF;

        -- Validate table-level unique_constraints[] if present (table_name not required)
        IF v_table_entry ? 'unique_constraints' THEN
            IF jsonb_typeof(v_table_entry->'unique_constraints') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) "unique_constraints" must be an array', v_table_idx, v_table_name;
            END IF;

            v_tbl_uniq_idx := 0;
            FOR v_tbl_uniq_entry IN SELECT jsonb_array_elements(v_table_entry->'unique_constraints') LOOP
                IF jsonb_typeof(v_tbl_uniq_entry) != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) unique_constraints[%] must be an object', v_table_idx, v_table_name, v_tbl_uniq_idx;
                END IF;

                IF NOT (v_tbl_uniq_entry ? 'columns') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) unique_constraints[%] missing required key "columns"', v_table_idx, v_table_name, v_tbl_uniq_idx;
                END IF;

                IF jsonb_typeof(v_tbl_uniq_entry->'columns') != 'array' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) unique_constraints[%] "columns" must be an array', v_table_idx, v_table_name, v_tbl_uniq_idx;
                END IF;

                IF jsonb_array_length(v_tbl_uniq_entry->'columns') = 0 THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: tables[%] (table_name=%) unique_constraints[%] "columns" must not be empty', v_table_idx, v_table_name, v_tbl_uniq_idx;
                END IF;

                v_tbl_uniq_idx := v_tbl_uniq_idx + 1;
            END LOOP;
        END IF;

        v_table_idx := v_table_idx + 1;
    END LOOP;

    -- Validate relations[] if present
    IF v_definition ? 'relations' THEN
        IF jsonb_typeof(v_definition->'relations') != 'array' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "relations" must be an array, got %', jsonb_typeof(v_definition->'relations');
        END IF;

        v_relation_idx := 0;
        FOR v_relation_entry IN SELECT jsonb_array_elements(v_definition->'relations') LOOP

            IF jsonb_typeof(v_relation_entry) != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] must be an object', v_relation_idx;
            END IF;

            IF NOT (v_relation_entry ? '$type') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] missing required key "$type"', v_relation_idx;
            END IF;

            IF NOT (v_relation_entry ? 'source_table') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] missing required key "source_table"', v_relation_idx;
            END IF;

            IF NOT (v_relation_entry ? 'target_table') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] missing required key "target_table"', v_relation_idx;
            END IF;

            -- source_schema and target_schema are optional strings
            IF v_relation_entry ? 'source_schema' AND jsonb_typeof(v_relation_entry->'source_schema') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] "source_schema" must be a string', v_relation_idx;
            END IF;

            IF v_relation_entry ? 'target_schema' AND jsonb_typeof(v_relation_entry->'target_schema') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] "target_schema" must be a string', v_relation_idx;
            END IF;

            -- data key is optional, but if present must be an object
            IF v_relation_entry ? 'data' AND jsonb_typeof(v_relation_entry->'data') != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: relations[%] "data" must be an object', v_relation_idx;
            END IF;

            v_relation_idx := v_relation_idx + 1;
        END LOOP;
    END IF;

    -- Validate indexes[] if present
    IF v_definition ? 'indexes' THEN
        IF jsonb_typeof(v_definition->'indexes') != 'array' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "indexes" must be an array, got %', jsonb_typeof(v_definition->'indexes');
        END IF;

        v_index_idx := 0;
        FOR v_index_entry IN SELECT jsonb_array_elements(v_definition->'indexes') LOOP

            IF jsonb_typeof(v_index_entry) != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] must be an object', v_index_idx;
            END IF;

            IF NOT (v_index_entry ? 'table_name') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] missing required key "table_name"', v_index_idx;
            END IF;

            -- schema_name is optional
            IF v_index_entry ? 'schema_name' AND jsonb_typeof(v_index_entry->'schema_name') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] "schema_name" must be a string', v_index_idx;
            END IF;

            -- Require either "column" (single) or "columns" (multi-column array)
            IF NOT (v_index_entry ? 'column') AND NOT (v_index_entry ? 'columns') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] missing required key "column" (or "columns" for multi-column)', v_index_idx;
            END IF;

            -- If "columns" is present, it must be an array
            IF v_index_entry ? 'columns' AND jsonb_typeof(v_index_entry->'columns') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] "columns" must be an array', v_index_idx;
            END IF;

            IF NOT (v_index_entry ? 'access_method') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] missing required key "access_method"', v_index_idx;
            END IF;

            -- options key is optional, but if present must be an object
            IF v_index_entry ? 'options' AND jsonb_typeof(v_index_entry->'options') != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] "options" must be an object', v_index_idx;
            END IF;

            -- op_classes key is optional, but if present must be an array
            IF v_index_entry ? 'op_classes' AND jsonb_typeof(v_index_entry->'op_classes') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: indexes[%] "op_classes" must be an array', v_index_idx;
            END IF;

            v_index_idx := v_index_idx + 1;
        END LOOP;
    END IF;

    -- Validate full_text_searches[] if present
    IF v_definition ? 'full_text_searches' THEN
        IF jsonb_typeof(v_definition->'full_text_searches') != 'array' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "full_text_searches" must be an array, got %', jsonb_typeof(v_definition->'full_text_searches');
        END IF;

        v_fts_idx := 0;
        FOR v_fts_entry IN SELECT jsonb_array_elements(v_definition->'full_text_searches') LOOP

            IF jsonb_typeof(v_fts_entry) != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] must be an object', v_fts_idx;
            END IF;

            IF NOT (v_fts_entry ? 'table_name') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] missing required key "table_name"', v_fts_idx;
            END IF;

            -- schema_name is optional
            IF v_fts_entry ? 'schema_name' AND jsonb_typeof(v_fts_entry->'schema_name') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] "schema_name" must be a string', v_fts_idx;
            END IF;

            IF NOT (v_fts_entry ? 'field') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] missing required key "field"', v_fts_idx;
            END IF;

            IF NOT (v_fts_entry ? 'sources') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] missing required key "sources"', v_fts_idx;
            END IF;

            IF jsonb_typeof(v_fts_entry->'sources') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] "sources" must be an array', v_fts_idx;
            END IF;

            IF jsonb_array_length(v_fts_entry->'sources') = 0 THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] "sources" array must not be empty', v_fts_idx;
            END IF;

            -- Validate each source entry
            v_source_idx := 0;
            WHILE v_source_idx < jsonb_array_length(v_fts_entry->'sources') LOOP
                v_source_entry := v_fts_entry->'sources'->v_source_idx;

                IF jsonb_typeof(v_source_entry) != 'object' THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] sources[%] must be an object', v_fts_idx, v_source_idx;
                END IF;

                IF NOT (v_source_entry ? 'field') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] sources[%] missing required key "field"', v_fts_idx, v_source_idx;
                END IF;

                IF NOT (v_source_entry ? 'weight') THEN
                    RAISE EXCEPTION 'VALIDATE_BLUEPRINT: full_text_searches[%] sources[%] missing required key "weight"', v_fts_idx, v_source_idx;
                END IF;

                v_source_idx := v_source_idx + 1;
            END LOOP;

            v_fts_idx := v_fts_idx + 1;
        END LOOP;
    END IF;

    -- Validate unique_constraints[] if present
    IF v_definition ? 'unique_constraints' THEN
        IF jsonb_typeof(v_definition->'unique_constraints') != 'array' THEN
            RAISE EXCEPTION 'VALIDATE_BLUEPRINT: "unique_constraints" must be an array, got %', jsonb_typeof(v_definition->'unique_constraints');
        END IF;

        v_uniq_idx := 0;
        FOR v_uniq_entry IN SELECT jsonb_array_elements(v_definition->'unique_constraints') LOOP

            IF jsonb_typeof(v_uniq_entry) != 'object' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: unique_constraints[%] must be an object', v_uniq_idx;
            END IF;

            IF NOT (v_uniq_entry ? 'table_name') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: unique_constraints[%] missing required key "table_name"', v_uniq_idx;
            END IF;

            -- schema_name is optional
            IF v_uniq_entry ? 'schema_name' AND jsonb_typeof(v_uniq_entry->'schema_name') != 'string' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: unique_constraints[%] "schema_name" must be a string', v_uniq_idx;
            END IF;

            IF NOT (v_uniq_entry ? 'columns') THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: unique_constraints[%] missing required key "columns"', v_uniq_idx;
            END IF;

            IF jsonb_typeof(v_uniq_entry->'columns') != 'array' THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: unique_constraints[%] "columns" must be an array', v_uniq_idx;
            END IF;

            IF jsonb_array_length(v_uniq_entry->'columns') = 0 THEN
                RAISE EXCEPTION 'VALIDATE_BLUEPRINT: unique_constraints[%] "columns" array must not be empty', v_uniq_idx;
            END IF;

            v_uniq_idx := v_uniq_idx + 1;
        END LOOP;
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql VOLATILE;

COMMENT ON FUNCTION metaschema_modules_public.tg_validate_blueprint_definition IS
    'Trigger function that validates the blueprint definition format on INSERT/UPDATE. Ensures structural correctness: optional membership_types[] with name/prefix and optional boolean flags, tables[] with table_name and optional nodes[], policies[], grants[], and table-level indexes[]/full_text_searches[]/unique_constraints[] (without table_name). Also validates top-level relations[] with $type/source_table/target_table, indexes[] with table_name/column/access_method, full_text_searches[] with table_name/field/sources[], unique_constraints[] with table_name/columns[]. Both table-level and top-level definitions are supported for indexes, FTS, and unique constraints. Rejects malformed definitions before they reach construct_blueprint().';

-- ==============================================================================
-- Patch: tg_set_secure_table_provision_deterministic_id
-- The platform's deterministic-ID trigger for secure_table_provision references
-- NEW.node_type, but that column does not exist on secure_table_provision.
-- This causes "record \"new\" has no field \"node_type\"" when metaschema.deterministic_ids
-- is enabled. Fix: use NEW.table_name (which does exist) as the second seed key.
-- Guarded: only create when metaschema_modules_private exists (platform present).
-- ==============================================================================

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'metaschema_modules_private') THEN
        EXECUTE $func$
            CREATE OR REPLACE FUNCTION metaschema_modules_private.tg_set_secure_table_provision_deterministic_id()
            RETURNS TRIGGER AS $body$
            BEGIN
                IF current_setting('metaschema.deterministic_ids', true) = 'true' THEN
                    NEW.id := metaschema_private.deterministic_id(NEW.table_id, NEW.table_name);
                END IF;
                RETURN NEW;
            END;
            $body$ LANGUAGE plpgsql;
        $func$;
    END IF;
END $$;

-- ==============================================================================
-- Patch: GRANT UPDATE on app_memberships to authenticated role + auto-approve
-- The platform blocks INSERT on app_memberships via RLS (by design). Instead,
-- app_membership_defaults auto-creates a row for each new user with
-- is_approved=false. This patch:
--   1. GRANTs UPDATE so the admin SDK can approve existing memberships
--   2. Updates all existing memberships to is_approved=true, is_verified=true
--   3. Updates app_membership_defaults so future sign-ups auto-approve
-- The RLS UPDATE policy already restricts UPDATEs to users with admin
-- permissions (bit 1), so this is safe.
-- ==============================================================================

do $$
declare
    v_schema text;
begin
    -- Schema-based tenancy: the physical DB is 'constructive' and every tenant
    -- has its own {tenant}_memberships_public schema inside it. Select the
    -- tenant schema — anything that is NOT the platform's own constructive_*
    -- schemas (current_database() would wrongly match those).
    select schema_name into v_schema
    from information_schema.schemata
    where (schema_name like '%memberships-public'
           OR schema_name like '%memberships_public')
      and schema_name not like 'constructive%'
    order by schema_name desc
    limit 1;

    if v_schema is not null then
        -- Grant UPDATE so admin SDK can approve memberships
        execute format('GRANT UPDATE ON %I.app_memberships TO authenticated', v_schema);
        raise notice 'Granted UPDATE on %.app_memberships to authenticated', v_schema;

        -- Auto-approve all existing app memberships
        execute format('UPDATE %I.app_memberships SET is_approved = true, is_verified = true, is_active = true WHERE is_approved = false', v_schema);
        raise notice 'Auto-approved all app memberships in %', v_schema;

        -- Auto-approve future sign-ups via defaults
        execute format('UPDATE %I.app_membership_defaults SET is_approved = true, is_verified = true WHERE is_approved = false', v_schema);
        raise notice 'Auto-approved app_membership_defaults in %', v_schema;
    else
        raise notice 'No tenant memberships schema found — skipping app_memberships patches';
    end if;
end;
$$;

-- ==============================================================================
-- Patch: Grant full app permissions to OAuth/identity-created users
-- Users created via sign_up_identity (OAuth/SSO flow) get an auto-created
-- app_memberships row with ZERO permissions, so org creation fails with
-- "permission denied for table users" (the RLS policies check the app
-- membership permission bits). This patch:
--   1. Backfills existing identity users (connected_accounts owners)
--   2. Installs a SECURITY DEFINER trigger so every FUTURE OAuth sign-up
--      automatically gets full app permissions (is_admin/is_owner/all bits)
-- ==============================================================================

do $$
declare
    v_memberships_schema text;
    v_identifiers_schema text;
    v_all_perms bit(64) := repeat('1', 64)::bit(64);
begin
    select schema_name into v_memberships_schema
    from information_schema.schemata
    where (schema_name like '%memberships-public'
           OR schema_name like '%memberships_public')
      and schema_name not like 'constructive%'
    order by schema_name desc
    limit 1;

    select schema_name into v_identifiers_schema
    from information_schema.schemata
    where schema_name like '%user_identifiers_private'
      and schema_name not like 'constructive%'
    order by schema_name desc
    limit 1;

    if v_memberships_schema is null or v_identifiers_schema is null then
        raise notice 'Tenant memberships/identifiers schemas not found — skipping identity permission patch';
        return;
    end if;

    -- 1. Backfill existing identity users (e.g. the SSO test user)
    execute format(
        'UPDATE %I.app_memberships am
         SET is_admin = true, is_owner = true, permissions = $1
         WHERE am.actor_id IN (SELECT ca.owner_id FROM %I.connected_accounts ca)
           AND (am.is_admin = false OR am.is_owner = false OR am.permissions <> $1)',
        v_memberships_schema, v_identifiers_schema)
        using v_all_perms;

    -- 2. Trigger function — SECURITY DEFINER so it bypasses RLS and can
    --    update app_memberships regardless of the invoking role.
    execute format(
        'CREATE OR REPLACE FUNCTION %I.tg_grant_full_perms_on_identity()
         RETURNS TRIGGER AS $body$
         DECLARE
           v_all_perms bit(64) := repeat(''1'', 64)::bit(64);
         BEGIN
           UPDATE %I.app_memberships
           SET is_admin = true, is_owner = true, permissions = v_all_perms
           WHERE actor_id = NEW.owner_id
             AND (is_admin = false OR is_owner = false OR permissions <> v_all_perms);
           RETURN NEW;
         END;
         $body$ LANGUAGE plpgsql SECURITY DEFINER',
        v_identifiers_schema, v_memberships_schema);

    execute format(
        'DROP TRIGGER IF EXISTS tg_grant_full_perms_on_identity ON %I.connected_accounts',
        v_identifiers_schema);
    execute format(
        'CREATE TRIGGER tg_grant_full_perms_on_identity
         AFTER INSERT ON %I.connected_accounts
         FOR EACH ROW EXECUTE FUNCTION %I.tg_grant_full_perms_on_identity()',
        v_identifiers_schema, v_identifiers_schema);

    raise notice 'Granted full app permissions to identity users (backfill + trigger)';
end;
$$;

-- ==============================================================================
-- Patch: Grant INSERT on users to authenticated (org creation)
-- The createUser mutation (used by org creation, type=2) lets PostGraphile
-- supply the primary key, but the auth:hardened grants only cover
-- display_name/profile_picture/type/username — id (and friends) are missing,
-- so INSERT fails with "permission denied for table users". The RLS WITH
-- CHECK policy still gates the row (requires permission bit 5 AND type = 2),
-- so table-level INSERT remains safe: only users with the org-creation bit
-- can insert org-type rows.
-- ==============================================================================

do $$
declare
    v_schema text;
begin
    select schema_name into v_schema
    from information_schema.schemata
    where schema_name like '%users_public'
      and schema_name not like 'constructive%'
    order by schema_name desc
    limit 1;

    if v_schema is not null then
        execute format('GRANT INSERT ON %I.users TO authenticated', v_schema);
        raise notice 'Granted INSERT on %.users to authenticated', v_schema;
    end if;
end;
$$;

COMMIT;
