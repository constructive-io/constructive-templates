-- Deploy: schemas/routing_public/tables/platform_apis/indexes/platform_apis_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table
-- requires: schemas/routing_public/tables/platform_apis/columns/updated_at/column


CREATE INDEX platform_apis_updated_at_idx ON routing_public.platform_apis (updated_at);