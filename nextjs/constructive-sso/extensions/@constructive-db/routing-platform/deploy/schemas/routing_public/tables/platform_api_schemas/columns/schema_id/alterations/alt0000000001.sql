-- Deploy: schemas/routing_public/tables/platform_api_schemas/columns/schema_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table
-- requires: schemas/routing_public/tables/platform_api_schemas/columns/schema_id/column


ALTER TABLE routing_public.platform_api_schemas 
  ALTER COLUMN schema_id SET NOT NULL;