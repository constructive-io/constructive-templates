-- Revert: schemas/catalog_public/tables/domains/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.domains 
  ALTER COLUMN id DROP NOT NULL;