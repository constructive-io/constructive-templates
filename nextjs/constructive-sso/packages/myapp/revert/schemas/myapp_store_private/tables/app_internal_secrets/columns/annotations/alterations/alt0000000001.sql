-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/columns/annotations/alterations/alt0000000001


ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN annotations DROP NOT NULL;


