-- Revert: schemas/catalog_private/tables/domains/columns/hostname/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN hostname DROP NOT NULL;