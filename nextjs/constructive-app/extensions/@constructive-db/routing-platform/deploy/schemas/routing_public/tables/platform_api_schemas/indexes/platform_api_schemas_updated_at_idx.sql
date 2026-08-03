-- Deploy: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table
-- requires: schemas/routing_public/tables/platform_api_schemas/columns/updated_at/column


CREATE INDEX platform_api_schemas_updated_at_idx ON routing_public.platform_api_schemas (updated_at);