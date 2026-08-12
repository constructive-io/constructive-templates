-- Revert: schemas/routing_public/tables/platform_site_modules/columns/updated_at/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN updated_at RESTRICT;