-- Revert: schemas/routing_public/tables/platform_site_modules/columns/created_at/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN created_at RESTRICT;