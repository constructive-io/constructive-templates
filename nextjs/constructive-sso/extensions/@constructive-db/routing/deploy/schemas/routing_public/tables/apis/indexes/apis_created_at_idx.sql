-- Deploy: schemas/routing_public/tables/apis/indexes/apis_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/routing_public/tables/apis/columns/created_at/column


CREATE INDEX apis_created_at_idx ON routing_public.apis (created_at);