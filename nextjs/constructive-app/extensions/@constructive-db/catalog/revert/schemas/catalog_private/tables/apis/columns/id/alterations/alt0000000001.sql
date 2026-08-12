-- Revert: schemas/catalog_private/tables/apis/columns/id/alterations/alt0000000001


ALTER TABLE catalog_private.apis 
  ALTER COLUMN id DROP NOT NULL;