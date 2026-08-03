-- Deploy: schemas/routing_public/tables/platform_domain_events/indexes/platform_domain_events_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table
-- requires: schemas/routing_public/tables/platform_domain_events/columns/updated_at/column


CREATE INDEX platform_domain_events_updated_at_idx ON routing_public.platform_domain_events (updated_at);