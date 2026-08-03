-- Revert: schemas/catalog_public/tables/domains/columns/is_wildcard/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN is_wildcard RESTRICT;