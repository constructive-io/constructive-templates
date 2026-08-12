-- Revert: schemas/catalog_private/tables/domains/columns/database_id/alterations/alt0000000001


ALTER TABLE catalog_private.domains 
  ALTER COLUMN database_id DROP NOT NULL;