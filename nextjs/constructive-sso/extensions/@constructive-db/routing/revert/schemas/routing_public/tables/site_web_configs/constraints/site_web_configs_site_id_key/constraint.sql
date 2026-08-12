-- Revert: schemas/routing_public/tables/site_web_configs/constraints/site_web_configs_site_id_key/constraint


ALTER TABLE routing_public.site_web_configs 
  DROP CONSTRAINT site_web_configs_site_id_key RESTRICT;