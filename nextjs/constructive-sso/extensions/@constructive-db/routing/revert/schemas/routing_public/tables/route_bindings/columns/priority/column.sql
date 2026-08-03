-- Revert: schemas/routing_public/tables/route_bindings/columns/priority/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN priority RESTRICT;