-- Deploy: schemas/routing_public/tables/managed_domains/indexes/managed_domains_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table
-- requires: schemas/routing_public/tables/managed_domains/columns/updated_at/column


CREATE INDEX managed_domains_updated_at_idx ON routing_public.managed_domains (updated_at);