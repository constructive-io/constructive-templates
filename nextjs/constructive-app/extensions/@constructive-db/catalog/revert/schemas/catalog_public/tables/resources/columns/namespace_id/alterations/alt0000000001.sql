-- Revert: schemas/catalog_public/tables/resources/columns/namespace_id/alterations/alt0000000001


ALTER TABLE catalog_public.resources 
  ALTER COLUMN namespace_id DROP NOT NULL;