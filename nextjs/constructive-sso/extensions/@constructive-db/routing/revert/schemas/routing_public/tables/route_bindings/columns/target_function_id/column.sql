-- Revert: schemas/routing_public/tables/route_bindings/columns/target_function_id/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN target_function_id RESTRICT;