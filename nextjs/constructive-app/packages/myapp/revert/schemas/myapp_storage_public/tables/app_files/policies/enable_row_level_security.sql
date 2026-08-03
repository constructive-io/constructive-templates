-- Revert: schemas/myapp_storage_public/tables/app_files/policies/enable_row_level_security


ALTER TABLE myapp_storage_public.app_files 
  DISABLE ROW LEVEL SECURITY;


