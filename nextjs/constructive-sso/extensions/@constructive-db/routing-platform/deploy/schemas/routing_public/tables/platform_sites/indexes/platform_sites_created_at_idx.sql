-- Deploy: schemas/routing_public/tables/platform_sites/indexes/platform_sites_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/routing_public/tables/platform_sites/columns/created_at/column


CREATE INDEX platform_sites_created_at_idx ON routing_public.platform_sites (created_at);