-- Revert: schemas/catalog_public/tables/sites/columns/config/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN config RESTRICT;