-- Deploy: schemas/routing_public/tables/http_routes/indexes/http_routes_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/database_id/column


CREATE INDEX http_routes_database_id_idx ON routing_public.http_routes (database_id);