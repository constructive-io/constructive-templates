-- Revert: schemas/routing_public/tables/platform_site_web_configs/constraints/platform_site_web_configs_pkey/constraint


ALTER TABLE routing_public.platform_site_web_configs 
  DROP CONSTRAINT platform_site_web_configs_pkey RESTRICT;