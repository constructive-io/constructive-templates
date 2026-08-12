-- Revert: schemas/routing_public/tables/sites/constraints/sites_installation_id_fkey/constraint


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_installation_id_fkey RESTRICT;