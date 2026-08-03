-- Deploy: schemas/routing_public/tables/platform_api_schemas/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table


ALTER TABLE routing_public.platform_api_schemas 
  ADD COLUMN id uuid;