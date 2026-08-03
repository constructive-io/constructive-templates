-- Revert: schemas/routing_public/tables/apis/columns/database_id/column


ALTER TABLE routing_public.apis 
  DROP COLUMN database_id RESTRICT;