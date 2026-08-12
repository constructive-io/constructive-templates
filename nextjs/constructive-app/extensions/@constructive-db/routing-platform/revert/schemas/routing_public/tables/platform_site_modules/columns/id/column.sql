-- Revert: schemas/routing_public/tables/platform_site_modules/columns/id/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN id RESTRICT;