-- Revert: schemas/catalog_public/tables/namespaces/columns/id/alterations/alt0000000001


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN id DROP NOT NULL;