-- Deploy: schemas/routing_public/tables/platform_api_schemas/constraints/platform_api_schemas_api_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table
-- requires: schemas/routing_public/tables/platform_api_schemas/table


ALTER TABLE routing_public.platform_api_schemas 
  ADD CONSTRAINT platform_api_schemas_api_id_fkey
    FOREIGN KEY(api_id)
    REFERENCES routing_public.platform_apis (id)
    ON DELETE CASCADE;