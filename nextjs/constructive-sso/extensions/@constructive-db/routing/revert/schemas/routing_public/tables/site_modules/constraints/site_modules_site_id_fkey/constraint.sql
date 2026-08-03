-- Revert: schemas/routing_public/tables/site_modules/constraints/site_modules_site_id_fkey/constraint


ALTER TABLE routing_public.site_modules 
  DROP CONSTRAINT site_modules_site_id_fkey RESTRICT;