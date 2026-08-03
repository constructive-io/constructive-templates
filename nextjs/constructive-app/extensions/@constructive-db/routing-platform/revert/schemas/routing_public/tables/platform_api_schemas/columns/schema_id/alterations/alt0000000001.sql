-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/schema_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_api_schemas 
  ALTER COLUMN schema_id DROP NOT NULL;