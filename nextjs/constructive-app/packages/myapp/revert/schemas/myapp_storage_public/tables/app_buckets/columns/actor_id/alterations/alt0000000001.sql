-- Revert: schemas/myapp_storage_public/tables/app_buckets/columns/actor_id/alterations/alt0000000001


ALTER TABLE myapp_storage_public.app_buckets 
  ALTER COLUMN actor_id DROP NOT NULL;


