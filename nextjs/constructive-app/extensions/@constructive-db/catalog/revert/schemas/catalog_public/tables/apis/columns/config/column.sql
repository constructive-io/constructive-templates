-- Revert: schemas/catalog_public/tables/apis/columns/config/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN config RESTRICT;