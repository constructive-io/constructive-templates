-- Revert: schemas/routing_public/tables/platform_site_web_configs/columns/clean_urls/column


ALTER TABLE routing_public.platform_site_web_configs 
  DROP COLUMN clean_urls RESTRICT;