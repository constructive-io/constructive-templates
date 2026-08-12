-- Revert: schemas/routing_public/tables/api_schemas/columns/database_id/column


ALTER TABLE routing_public.api_schemas 
  DROP COLUMN database_id RESTRICT;