-- Deploy: schemas/routing_public/tables/platform_domain_events/indexes/platform_domain_events_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table
-- requires: schemas/routing_public/tables/platform_domain_events/columns/created_at/column


CREATE INDEX platform_domain_events_created_at_idx ON routing_public.platform_domain_events (created_at);