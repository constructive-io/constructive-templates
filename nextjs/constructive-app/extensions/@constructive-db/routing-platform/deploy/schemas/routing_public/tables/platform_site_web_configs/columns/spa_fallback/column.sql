-- Deploy: schemas/routing_public/tables/platform_site_web_configs/columns/spa_fallback/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_web_configs/table


ALTER TABLE routing_public.platform_site_web_configs 
  ADD COLUMN spa_fallback boolean;