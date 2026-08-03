-- Revert: schemas/routing_public/tables/route_bindings/columns/path/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN path RESTRICT;