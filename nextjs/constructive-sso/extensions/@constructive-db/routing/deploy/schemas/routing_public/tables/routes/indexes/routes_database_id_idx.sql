-- Deploy: schemas/routing_public/tables/routes/indexes/routes_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/database_id/column


CREATE INDEX routes_database_id_idx ON routing_public.routes (database_id);