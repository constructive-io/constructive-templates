-- Deploy: schemas/routing_public/tables/api_schemas/constraints/api_schemas_api_id_schema_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_schemas/table


ALTER TABLE routing_public.api_schemas 
  ADD CONSTRAINT api_schemas_api_id_schema_id_key 
    UNIQUE (api_id, schema_id);