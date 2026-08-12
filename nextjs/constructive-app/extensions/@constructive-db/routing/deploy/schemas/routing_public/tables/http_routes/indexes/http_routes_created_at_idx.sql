-- Deploy: schemas/routing_public/tables/http_routes/indexes/http_routes_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/created_at/column


CREATE INDEX http_routes_created_at_idx ON routing_public.http_routes (created_at);