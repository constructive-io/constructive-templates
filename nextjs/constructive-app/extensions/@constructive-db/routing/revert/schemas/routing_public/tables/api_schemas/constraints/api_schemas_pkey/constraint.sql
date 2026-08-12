-- Revert: schemas/routing_public/tables/api_schemas/constraints/api_schemas_pkey/constraint


ALTER TABLE routing_public.api_schemas 
  DROP CONSTRAINT api_schemas_pkey RESTRICT;