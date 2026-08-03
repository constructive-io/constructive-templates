-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/indexes/app_internal_secrets_namespace_id_name_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/retired_at/column


CREATE UNIQUE INDEX app_internal_secrets_namespace_id_name_idx ON myapp_store_private.app_internal_secrets ( namespace_id, name ) WHERE retired_at IS NULL;

