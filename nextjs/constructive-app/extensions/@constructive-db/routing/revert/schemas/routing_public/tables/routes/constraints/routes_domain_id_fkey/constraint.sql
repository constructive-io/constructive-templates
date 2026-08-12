-- Revert: schemas/routing_public/tables/routes/constraints/routes_domain_id_fkey/constraint


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_domain_id_fkey RESTRICT;