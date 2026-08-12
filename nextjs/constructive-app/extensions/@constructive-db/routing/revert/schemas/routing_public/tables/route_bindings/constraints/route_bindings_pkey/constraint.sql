-- Revert: schemas/routing_public/tables/route_bindings/constraints/route_bindings_pkey/constraint


ALTER TABLE routing_public.route_bindings 
  DROP CONSTRAINT route_bindings_pkey RESTRICT;