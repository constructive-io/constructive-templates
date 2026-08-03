-- Deploy: schemas/routing_public/tables/api_schemas/columns/schema_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_schemas/table


ALTER TABLE routing_public.api_schemas 
  ADD COLUMN schema_id uuid;