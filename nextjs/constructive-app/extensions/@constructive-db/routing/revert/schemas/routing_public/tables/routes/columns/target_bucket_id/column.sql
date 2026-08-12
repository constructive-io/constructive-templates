-- Revert: schemas/routing_public/tables/routes/columns/target_bucket_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN target_bucket_id RESTRICT;