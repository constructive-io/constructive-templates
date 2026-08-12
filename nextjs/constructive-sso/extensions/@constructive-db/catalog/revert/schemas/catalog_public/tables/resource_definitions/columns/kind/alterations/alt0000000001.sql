-- Revert: schemas/catalog_public/tables/resource_definitions/columns/kind/alterations/alt0000000001


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN kind DROP NOT NULL;