-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/policies/enable_row_level_security


ALTER TABLE myapp_store_private.app_internal_secrets 
  DISABLE ROW LEVEL SECURITY;


