-- Revert: schemas/routing_public/tables/routes/columns/target_function_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN target_function_id RESTRICT;