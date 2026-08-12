-- Revert: schemas/routing_public/tables/sites/constraints/sites_pkey/constraint


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_pkey RESTRICT;