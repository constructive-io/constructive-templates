-- Revert: schemas/myapp_storage_public/tables/app_files/columns/expiry_enqueued_at/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN expiry_enqueued_at RESTRICT;


