-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/labels/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/labels/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN labels SET DEFAULT '{}'::jsonb;

