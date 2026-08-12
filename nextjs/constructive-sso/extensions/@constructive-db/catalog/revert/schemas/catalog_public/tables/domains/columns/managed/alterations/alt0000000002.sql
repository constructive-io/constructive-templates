-- Revert: schemas/catalog_public/tables/domains/columns/managed/alterations/alt0000000002


ALTER TABLE catalog_public.domains 
  ALTER COLUMN managed DROP DEFAULT;