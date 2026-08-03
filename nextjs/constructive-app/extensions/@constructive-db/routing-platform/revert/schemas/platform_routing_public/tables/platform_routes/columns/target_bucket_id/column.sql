-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/target_bucket_id/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN target_bucket_id RESTRICT;