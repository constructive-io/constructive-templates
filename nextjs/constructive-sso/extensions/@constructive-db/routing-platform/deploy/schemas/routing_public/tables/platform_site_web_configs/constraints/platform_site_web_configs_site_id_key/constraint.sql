-- Deploy: schemas/routing_public/tables/platform_site_web_configs/constraints/platform_site_web_configs_site_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_web_configs/table


ALTER TABLE routing_public.platform_site_web_configs 
  ADD CONSTRAINT platform_site_web_configs_site_id_key 
    UNIQUE (site_id);