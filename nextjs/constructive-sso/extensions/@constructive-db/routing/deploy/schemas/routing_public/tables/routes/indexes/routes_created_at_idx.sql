-- Deploy: schemas/routing_public/tables/routes/indexes/routes_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/created_at/column


CREATE INDEX routes_created_at_idx ON routing_public.routes (created_at);