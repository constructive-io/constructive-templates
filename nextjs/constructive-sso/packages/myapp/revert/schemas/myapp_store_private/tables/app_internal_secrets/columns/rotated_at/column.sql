-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/columns/rotated_at/column


ALTER TABLE myapp_store_private.app_internal_secrets 
  DROP COLUMN rotated_at RESTRICT;


