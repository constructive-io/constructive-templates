-- Revert: schemas/catalog_private/tables/functions/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.functions 
  ALTER COLUMN id DROP NOT NULL;