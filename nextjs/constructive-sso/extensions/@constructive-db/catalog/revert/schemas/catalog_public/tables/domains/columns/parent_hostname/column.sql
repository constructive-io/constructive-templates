-- Revert: schemas/catalog_public/tables/domains/columns/parent_hostname/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN parent_hostname RESTRICT;