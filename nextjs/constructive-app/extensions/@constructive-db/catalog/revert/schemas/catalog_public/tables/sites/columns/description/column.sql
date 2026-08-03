-- Revert: schemas/catalog_public/tables/sites/columns/description/column


ALTER TABLE catalog_public.sites 
  DROP COLUMN description RESTRICT;