-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/schema_id/column


ALTER TABLE routing_public.platform_api_schemas 
  DROP COLUMN schema_id RESTRICT;