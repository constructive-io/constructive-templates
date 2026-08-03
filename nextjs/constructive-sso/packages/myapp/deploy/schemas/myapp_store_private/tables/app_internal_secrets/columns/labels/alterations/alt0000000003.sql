-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/labels/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/labels/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.labels IS E'Key/value pairs for selecting/filtering secrets';

