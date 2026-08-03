-- Revert: schemas/routing_public/tables/platform_site_modules/columns/data/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN data RESTRICT;