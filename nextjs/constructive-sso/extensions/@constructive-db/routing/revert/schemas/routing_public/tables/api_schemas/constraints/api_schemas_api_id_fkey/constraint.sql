-- Revert: schemas/routing_public/tables/api_schemas/constraints/api_schemas_api_id_fkey/constraint


ALTER TABLE routing_public.api_schemas 
  DROP CONSTRAINT api_schemas_api_id_fkey RESTRICT;