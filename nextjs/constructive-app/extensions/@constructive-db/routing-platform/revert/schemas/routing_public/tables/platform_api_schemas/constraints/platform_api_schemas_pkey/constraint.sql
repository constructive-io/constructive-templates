-- Revert: schemas/routing_public/tables/platform_api_schemas/constraints/platform_api_schemas_pkey/constraint


ALTER TABLE routing_public.platform_api_schemas 
  DROP CONSTRAINT platform_api_schemas_pkey RESTRICT;