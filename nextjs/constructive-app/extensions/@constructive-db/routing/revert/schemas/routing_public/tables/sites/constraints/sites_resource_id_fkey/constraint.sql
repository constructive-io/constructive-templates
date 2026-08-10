-- Revert: schemas/routing_public/tables/sites/constraints/sites_resource_id_fkey/constraint


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_resource_id_fkey RESTRICT;