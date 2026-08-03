-- Revert: schemas/routing_public/tables/platform_site_modules/columns/site_id/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN site_id RESTRICT;