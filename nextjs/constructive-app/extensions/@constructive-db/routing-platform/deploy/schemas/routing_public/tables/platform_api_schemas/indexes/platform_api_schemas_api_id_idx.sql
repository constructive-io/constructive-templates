-- Deploy: schemas/routing_public/tables/platform_api_schemas/indexes/platform_api_schemas_api_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table
-- requires: schemas/routing_public/tables/platform_api_schemas/columns/api_id/column


CREATE INDEX platform_api_schemas_api_id_idx ON routing_public.platform_api_schemas (api_id);