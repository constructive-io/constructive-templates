-- Revert: schemas/catalog_public/tables/domains/columns/hostname/column


ALTER TABLE catalog_public.domains 
  DROP COLUMN hostname RESTRICT;