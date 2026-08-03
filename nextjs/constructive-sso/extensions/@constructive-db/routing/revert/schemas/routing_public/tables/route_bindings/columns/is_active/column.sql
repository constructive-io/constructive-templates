-- Revert: schemas/routing_public/tables/route_bindings/columns/is_active/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN is_active RESTRICT;