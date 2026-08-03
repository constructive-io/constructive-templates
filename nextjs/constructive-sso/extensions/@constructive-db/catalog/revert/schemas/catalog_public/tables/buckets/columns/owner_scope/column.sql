-- Revert: schemas/catalog_public/tables/buckets/columns/owner_scope/column


ALTER TABLE catalog_public.buckets 
  DROP COLUMN owner_scope RESTRICT;