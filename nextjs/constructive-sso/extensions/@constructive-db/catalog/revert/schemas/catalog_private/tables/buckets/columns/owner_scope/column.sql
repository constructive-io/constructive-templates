-- Revert: schemas/catalog_private/tables/buckets/columns/owner_scope/column


ALTER TABLE catalog_private.buckets 
  DROP COLUMN owner_scope RESTRICT;