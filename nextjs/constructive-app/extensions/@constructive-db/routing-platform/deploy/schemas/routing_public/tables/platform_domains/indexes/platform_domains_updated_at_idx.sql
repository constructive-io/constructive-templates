-- Deploy: schemas/routing_public/tables/platform_domains/indexes/platform_domains_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table
-- requires: schemas/routing_public/tables/platform_domains/columns/updated_at/column


CREATE INDEX platform_domains_updated_at_idx ON routing_public.platform_domains (updated_at);