-- Revert: schemas/catalog_public/tables/resource_definitions/columns/created_at/alterations/alt0000000001


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN created_at DROP DEFAULT;