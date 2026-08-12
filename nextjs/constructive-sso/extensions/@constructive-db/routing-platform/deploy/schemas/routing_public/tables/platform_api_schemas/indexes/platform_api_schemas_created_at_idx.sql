-- Deploy: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table
-- requires: schemas/routing_public/tables/platform_api_schemas/columns/created_at/column


CREATE INDEX platform_api_schemas_created_at_idx ON routing_public.platform_api_schemas (created_at);