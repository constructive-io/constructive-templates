-- Deploy: schemas/routing_public/tables/pages/indexes/pages_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table
-- requires: schemas/routing_public/tables/pages/columns/database_id/column


CREATE INDEX pages_database_id_idx ON routing_public.pages (database_id);