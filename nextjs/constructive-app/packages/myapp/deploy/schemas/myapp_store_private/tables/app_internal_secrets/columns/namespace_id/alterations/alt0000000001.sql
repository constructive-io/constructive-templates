-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/namespace_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/namespace_id/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN namespace_id SET NOT NULL;

