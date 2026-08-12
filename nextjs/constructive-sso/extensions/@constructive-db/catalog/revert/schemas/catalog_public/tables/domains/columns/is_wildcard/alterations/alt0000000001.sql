-- Revert: schemas/catalog_public/tables/domains/columns/is_wildcard/alterations/alt0000000001


ALTER TABLE catalog_public.domains 
  ALTER COLUMN is_wildcard DROP NOT NULL;