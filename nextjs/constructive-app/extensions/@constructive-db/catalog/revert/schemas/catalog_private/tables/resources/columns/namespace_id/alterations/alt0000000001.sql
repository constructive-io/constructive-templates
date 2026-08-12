-- Revert: schemas/catalog_private/tables/resources/columns/namespace_id/alterations/alt0000000001


ALTER TABLE catalog_private.resources 
  ALTER COLUMN namespace_id DROP NOT NULL;