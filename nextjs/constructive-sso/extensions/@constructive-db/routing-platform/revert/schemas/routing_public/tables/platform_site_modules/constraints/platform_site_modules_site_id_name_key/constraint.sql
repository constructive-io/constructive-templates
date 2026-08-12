-- Revert: schemas/routing_public/tables/platform_site_modules/constraints/platform_site_modules_site_id_name_key/constraint


ALTER TABLE routing_public.platform_site_modules 
  DROP CONSTRAINT platform_site_modules_site_id_name_key RESTRICT;