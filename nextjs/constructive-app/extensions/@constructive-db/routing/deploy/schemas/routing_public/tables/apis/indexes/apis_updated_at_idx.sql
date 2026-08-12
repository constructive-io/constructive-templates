-- Deploy: schemas/routing_public/tables/apis/indexes/apis_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/routing_public/tables/apis/columns/updated_at/column


CREATE INDEX apis_updated_at_idx ON routing_public.apis (updated_at);