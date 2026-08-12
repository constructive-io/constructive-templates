-- Revert: schemas/catalog_public/tables/resource_definitions/columns/id/alterations/alt0000000002


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN id DROP DEFAULT;