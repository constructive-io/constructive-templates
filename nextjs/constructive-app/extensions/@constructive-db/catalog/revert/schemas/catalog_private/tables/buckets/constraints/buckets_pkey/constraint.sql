-- Revert: schemas/catalog_private/tables/buckets/constraints/buckets_pkey/constraint


ALTER TABLE catalog_private.buckets 
  DROP CONSTRAINT buckets_pkey RESTRICT;