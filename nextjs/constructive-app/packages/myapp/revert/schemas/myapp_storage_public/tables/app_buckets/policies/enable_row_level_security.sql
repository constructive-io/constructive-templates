-- Revert: schemas/myapp_storage_public/tables/app_buckets/policies/enable_row_level_security


ALTER TABLE myapp_storage_public.app_buckets 
  DISABLE ROW LEVEL SECURITY;


