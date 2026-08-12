-- Deploy: schemas/routing_public/tables/routes/indexes/routes_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/updated_at/column


CREATE INDEX routes_updated_at_idx ON routing_public.routes (updated_at);