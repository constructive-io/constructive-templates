-- Revert: schemas/catalog_public/tables/resource_definitions/columns/slug/alterations/alt0000000001


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN slug DROP NOT NULL;