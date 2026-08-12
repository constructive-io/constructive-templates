-- Revert: schemas/catalog_public/tables/buckets/constraints/buckets_pkey/constraint


ALTER TABLE catalog_public.buckets 
  DROP CONSTRAINT buckets_pkey RESTRICT;