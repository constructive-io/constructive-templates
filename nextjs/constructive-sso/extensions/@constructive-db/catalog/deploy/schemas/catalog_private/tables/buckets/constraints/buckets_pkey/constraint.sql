-- Deploy: schemas/catalog_private/tables/buckets/constraints/buckets_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/buckets/table


ALTER TABLE catalog_private.buckets 
  ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);