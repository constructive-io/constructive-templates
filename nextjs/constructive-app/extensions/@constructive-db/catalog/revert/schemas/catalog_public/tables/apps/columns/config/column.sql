-- Revert: schemas/catalog_public/tables/apps/columns/config/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN config RESTRICT;