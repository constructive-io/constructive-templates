-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/indexes/app_internal_secrets_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/updated_at/column


CREATE INDEX app_internal_secrets_updated_at_idx ON myapp_store_private.app_internal_secrets ( updated_at );

