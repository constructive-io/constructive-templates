-- Revert: schemas/catalog_public/tables/functions/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.functions 
  ALTER COLUMN id DROP NOT NULL;