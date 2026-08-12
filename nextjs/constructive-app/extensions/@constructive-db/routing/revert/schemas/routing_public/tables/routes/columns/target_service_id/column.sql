-- Revert: schemas/routing_public/tables/routes/columns/target_service_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN target_service_id RESTRICT;