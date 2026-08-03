-- Revert: schemas/routing_public/tables/route_bindings/columns/method/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN method RESTRICT;