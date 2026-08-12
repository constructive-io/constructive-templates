-- Deploy: schemas/routing_public/tables/api_schemas/indexes/api_schemas_api_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_schemas/table
-- requires: schemas/routing_public/tables/api_schemas/columns/api_id/column


CREATE INDEX api_schemas_api_id_idx ON routing_public.api_schemas (api_id);