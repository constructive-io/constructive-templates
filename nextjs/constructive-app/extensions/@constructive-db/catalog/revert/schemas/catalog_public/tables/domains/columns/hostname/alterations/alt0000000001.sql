-- Revert: schemas/catalog_public/tables/domains/columns/hostname/alterations/alt0000000001


ALTER TABLE catalog_public.domains 
  ALTER COLUMN hostname DROP NOT NULL;