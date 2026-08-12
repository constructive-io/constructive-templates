-- Deploy: schemas/routing_public/tables/sites/indexes/sites_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/sites/columns/created_at/column


CREATE INDEX sites_created_at_idx ON routing_public.sites (created_at);