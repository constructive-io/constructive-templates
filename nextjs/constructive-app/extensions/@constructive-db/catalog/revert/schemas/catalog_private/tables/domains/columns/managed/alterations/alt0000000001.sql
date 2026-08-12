-- Revert: schemas/catalog_private/tables/domains/columns/managed/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN managed DROP NOT NULL;