-- Revert: schemas/routing_public/tables/site_web_configs/columns/clean_urls/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN clean_urls RESTRICT;