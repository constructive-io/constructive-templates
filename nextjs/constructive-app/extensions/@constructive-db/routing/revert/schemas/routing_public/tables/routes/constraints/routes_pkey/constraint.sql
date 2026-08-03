-- Revert: schemas/routing_public/tables/routes/constraints/routes_pkey/constraint


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_pkey RESTRICT;