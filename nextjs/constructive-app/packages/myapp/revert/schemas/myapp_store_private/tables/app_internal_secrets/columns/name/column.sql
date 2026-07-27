-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/columns/name/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  DROP COLUMN name RESTRICT;


