-- Deploy: schemas/routing_public/tables/platform_domains/indexes/platform_domains_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/created_at/column


CREATE INDEX platform_domains_created_at_idx ON routing_public.platform_domains (created_at);