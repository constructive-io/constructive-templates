-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/columns/created_at/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  DROP COLUMN created_at RESTRICT;


