-- Deploy: schemas/myapp_storage_public/tables/app_buckets/constraints/app_buckets_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_buckets/table


ALTER TABLE myapp_storage_public.app_buckets 
  ADD CONSTRAINT app_buckets_pkey PRIMARY KEY (id);

