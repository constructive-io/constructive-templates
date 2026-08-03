-- Deploy: schemas/catalog_public/tables/buckets/constraints/buckets_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/buckets/table


ALTER TABLE catalog_public.buckets 
  ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);