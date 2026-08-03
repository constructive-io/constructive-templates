-- Revert: schemas/routing_public/tables/routes/columns/target_api_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN target_api_id RESTRICT;