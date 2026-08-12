-- Revert: schemas/routing_public/tables/platform_site_modules/columns/is_enabled/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN is_enabled RESTRICT;