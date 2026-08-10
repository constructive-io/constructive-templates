-- Revert: schemas/routing_public/tables/sites/columns/bucket_id/column


ALTER TABLE routing_public.sites 
  DROP COLUMN bucket_id RESTRICT;