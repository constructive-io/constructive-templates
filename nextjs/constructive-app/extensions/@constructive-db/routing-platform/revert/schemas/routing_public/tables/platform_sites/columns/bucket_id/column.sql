-- Revert: schemas/routing_public/tables/platform_sites/columns/bucket_id/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN bucket_id RESTRICT;