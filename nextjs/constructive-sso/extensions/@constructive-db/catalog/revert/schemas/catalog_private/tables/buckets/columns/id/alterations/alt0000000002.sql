-- Revert: schemas/catalog_private/tables/buckets/columns/id/alterations/alt0000000002


ALTER TABLE catalog_private.buckets 
  ALTER COLUMN id DROP DEFAULT;