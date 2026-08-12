-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/key_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/key_id/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN key_id SET NOT NULL;

