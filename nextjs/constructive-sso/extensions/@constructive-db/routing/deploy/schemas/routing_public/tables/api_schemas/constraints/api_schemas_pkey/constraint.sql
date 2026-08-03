-- Deploy: schemas/routing_public/tables/api_schemas/constraints/api_schemas_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_schemas/table


ALTER TABLE routing_public.api_schemas 
  ADD CONSTRAINT api_schemas_pkey PRIMARY KEY (id);