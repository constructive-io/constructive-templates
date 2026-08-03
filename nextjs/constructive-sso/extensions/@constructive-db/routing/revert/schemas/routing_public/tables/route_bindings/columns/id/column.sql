-- Revert: schemas/routing_public/tables/route_bindings/columns/id/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN id RESTRICT;