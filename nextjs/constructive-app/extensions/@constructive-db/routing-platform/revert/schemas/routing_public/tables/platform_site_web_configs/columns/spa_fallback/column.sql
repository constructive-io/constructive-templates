-- Revert: schemas/routing_public/tables/platform_site_web_configs/columns/spa_fallback/column


ALTER TABLE routing_public.platform_site_web_configs 
  DROP COLUMN spa_fallback RESTRICT;