-- Revert: schemas/catalog_public/tables/apps/columns/id/column


ALTER TABLE catalog_public.apps 
  DROP COLUMN id RESTRICT;