-- Deploy: schemas/routing_public/tables/sites/indexes/sites_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/sites/columns/updated_at/column


CREATE INDEX sites_updated_at_idx ON routing_public.sites (updated_at);