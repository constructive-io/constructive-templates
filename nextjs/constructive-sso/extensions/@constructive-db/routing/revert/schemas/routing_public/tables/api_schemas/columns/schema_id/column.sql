-- Revert: schemas/routing_public/tables/api_schemas/columns/schema_id/column


ALTER TABLE routing_public.api_schemas 
  DROP COLUMN schema_id RESTRICT;