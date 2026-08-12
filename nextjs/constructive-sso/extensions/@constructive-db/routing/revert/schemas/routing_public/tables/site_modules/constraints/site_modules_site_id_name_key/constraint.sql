-- Revert: schemas/routing_public/tables/site_modules/constraints/site_modules_site_id_name_key/constraint


ALTER TABLE routing_public.site_modules 
  DROP CONSTRAINT site_modules_site_id_name_key RESTRICT;