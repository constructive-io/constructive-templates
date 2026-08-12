-- Revert: schemas/routing_public/tables/route_bindings/columns/target_bucket_id/column


ALTER TABLE routing_public.route_bindings 
  DROP COLUMN target_bucket_id RESTRICT;