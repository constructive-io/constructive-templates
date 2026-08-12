-- Revert: schemas/routing_public/tables/route_bindings/columns/updated_at/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN updated_at RESTRICT;