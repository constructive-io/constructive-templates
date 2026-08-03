-- Revert: schemas/routing_public/tables/platform_api_schemas/constraints/platform_api_schemas_api_id_schema_id_key/constraint


ALTER TABLE routing_public.platform_api_schemas 
  DROP CONSTRAINT platform_api_schemas_api_id_schema_id_key RESTRICT;