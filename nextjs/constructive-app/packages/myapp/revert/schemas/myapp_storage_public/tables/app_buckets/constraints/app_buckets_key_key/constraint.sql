-- Revert: schemas/myapp_storage_public/tables/app_buckets/constraints/app_buckets_key_key/constraint


ALTER TABLE myapp_storage_public.app_buckets 
  DROP CONSTRAINT app_buckets_key_key;


