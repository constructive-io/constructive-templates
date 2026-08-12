-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/columns/id/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  DROP COLUMN id RESTRICT;


