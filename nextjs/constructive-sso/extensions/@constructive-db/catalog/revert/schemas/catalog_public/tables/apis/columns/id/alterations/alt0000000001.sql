-- Revert: schemas/catalog_public/tables/apis/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.apis 
  ALTER COLUMN id DROP NOT NULL;