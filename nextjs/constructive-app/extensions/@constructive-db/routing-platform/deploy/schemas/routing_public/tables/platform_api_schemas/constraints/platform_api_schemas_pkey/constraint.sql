-- Deploy: schemas/routing_public/tables/platform_api_schemas/constraints/platform_api_schemas_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table


ALTER TABLE routing_public.platform_api_schemas 
  ADD CONSTRAINT platform_api_schemas_pkey PRIMARY KEY (id);