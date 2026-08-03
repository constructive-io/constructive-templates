-- Revert: schemas/catalog_public/tables/resource_definitions/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN owner_scope DROP NOT NULL;