-- Revert: schemas/catalog_public/tables/resource_definitions/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_public.resource_definitions 
  ALTER COLUMN database_id DROP NOT NULL;