-- Revert: schemas/routing_public/tables/routes/columns/database_id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN database_id RESTRICT;