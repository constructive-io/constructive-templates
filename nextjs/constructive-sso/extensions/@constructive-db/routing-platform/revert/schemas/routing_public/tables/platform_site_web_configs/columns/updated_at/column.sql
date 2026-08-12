-- Revert: schemas/routing_public/tables/platform_site_web_configs/columns/updated_at/column


ALTER TABLE routing_public.platform_site_web_configs 
  DROP COLUMN updated_at RESTRICT;