-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/created_at/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN created_at SET DEFAULT now();

