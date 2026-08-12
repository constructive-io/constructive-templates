-- Revert: schemas/routing_public/tables/platform_sites/constraints/platform_sites_name_key/constraint


ALTER TABLE routing_public.platform_sites 
  DROP CONSTRAINT platform_sites_name_key RESTRICT;