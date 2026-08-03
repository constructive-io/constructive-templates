-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/name/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/name/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.name IS 'Key name identifying the secret';

