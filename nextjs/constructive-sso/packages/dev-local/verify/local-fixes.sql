-- Verify: local-fixes
-- Asserts the validator override has been applied by grepping the
-- function source for the membership_types OR-branch added in
-- constructive-db commit 5a35b43773.

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'metaschema_modules_public'
          AND p.proname = 'tg_validate_blueprint_definition'
          AND pg_get_functiondef(p.oid) LIKE '%membership_types%'
    ) THEN
        RAISE EXCEPTION 'verify: tg_validate_blueprint_definition missing membership_types branch';
    END IF;
END $$;

-- Verify: identity permission patch — the trigger must exist on the tenant's
-- connected_accounts table.
DO $$
DECLARE
    v_identifiers_schema text;
BEGIN
    SELECT schema_name INTO v_identifiers_schema
    FROM information_schema.schemata
    WHERE schema_name LIKE '%user_identifiers_private'
      AND schema_name NOT LIKE 'constructive%'
    ORDER BY schema_name DESC
    LIMIT 1;

    IF v_identifiers_schema IS NULL OR NOT EXISTS (
        SELECT 1 FROM pg_trigger t
        JOIN pg_class c ON c.oid = t.tgrelid
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE n.nspname = v_identifiers_schema
          AND c.relname = 'connected_accounts'
          AND t.tgname = 'tg_grant_full_perms_on_identity'
    ) THEN
        RAISE EXCEPTION 'verify: tg_grant_full_perms_on_identity trigger missing';
    END IF;
END $$;

