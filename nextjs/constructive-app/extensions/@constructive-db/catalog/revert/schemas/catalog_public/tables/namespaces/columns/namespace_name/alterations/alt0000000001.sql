-- Revert: schemas/catalog_public/tables/namespaces/columns/namespace_name/alterations/alt0000000001


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN namespace_name DROP NOT NULL;