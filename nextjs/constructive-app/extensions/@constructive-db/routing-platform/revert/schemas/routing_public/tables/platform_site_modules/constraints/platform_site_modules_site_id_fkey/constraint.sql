-- Revert: schemas/routing_public/tables/platform_site_modules/constraints/platform_site_modules_site_id_fkey/constraint


ALTER TABLE routing_public.platform_site_modules 
  DROP CONSTRAINT platform_site_modules_site_id_fkey RESTRICT;