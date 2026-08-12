-- Revert: schemas/myapp_storage_public/tables/app_files/columns/actor_id/column


ALTER TABLE myapp_storage_public.app_files 
  DROP COLUMN actor_id RESTRICT;


