-- Deploy: schemas/routing_public/tables/api_schemas/indexes/api_schemas_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_schemas/table
-- requires: schemas/routing_public/tables/api_schemas/columns/created_at/column


CREATE INDEX api_schemas_created_at_idx ON routing_public.api_schemas (created_at);