-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/annotations/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/annotations/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.annotations IS 'Freeform metadata for tooling and operational notes';

