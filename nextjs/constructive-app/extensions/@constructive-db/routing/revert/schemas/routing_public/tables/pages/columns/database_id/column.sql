-- Revert: schemas/routing_public/tables/pages/columns/database_id/column


ALTER TABLE routing_public.pages 
  DROP COLUMN database_id RESTRICT;