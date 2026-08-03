-- Revert: schemas/platform_routing_public/tables/platform_routes/constraints/platform_routes_target_bucket_id_fkey/constraint


ALTER TABLE platform_routing_public.platform_routes 
  DROP CONSTRAINT platform_routes_target_bucket_id_fkey RESTRICT;