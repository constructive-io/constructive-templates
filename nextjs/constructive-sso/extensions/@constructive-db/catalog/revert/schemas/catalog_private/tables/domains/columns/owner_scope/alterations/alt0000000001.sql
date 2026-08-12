-- Revert: schemas/catalog_private/tables/domains/columns/owner_scope/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN owner_scope DROP NOT NULL;