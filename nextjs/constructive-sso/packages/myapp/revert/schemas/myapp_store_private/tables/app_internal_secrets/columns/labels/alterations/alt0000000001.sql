-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/columns/labels/alterations/alt0000000001


ALTER TABLE myapp_store_private.app_internal_secrets 
  ALTER COLUMN labels DROP NOT NULL;


