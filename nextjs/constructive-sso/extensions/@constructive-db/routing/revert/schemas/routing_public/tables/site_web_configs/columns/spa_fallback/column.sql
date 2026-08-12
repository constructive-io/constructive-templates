-- Revert: schemas/routing_public/tables/site_web_configs/columns/spa_fallback/column


ALTER TABLE routing_public.site_web_configs 
  DROP COLUMN spa_fallback RESTRICT;