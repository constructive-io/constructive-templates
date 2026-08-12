-- Deploy: schemas/routing_public/tables/platform_managed_domains/indexes/platform_managed_domains_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/created_at/column


CREATE INDEX platform_managed_domains_created_at_idx ON routing_public.platform_managed_domains (created_at);