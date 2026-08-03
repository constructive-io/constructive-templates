-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/actor_id/column


ALTER TABLE myapp_storage_public.app_buckets 
  DROP COLUMN actor_id RESTRICT;


