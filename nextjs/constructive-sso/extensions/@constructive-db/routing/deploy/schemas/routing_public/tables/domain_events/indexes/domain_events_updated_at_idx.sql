-- Deploy: schemas/routing_public/tables/domain_events/indexes/domain_events_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/domain_events/columns/updated_at/column


CREATE INDEX domain_events_updated_at_idx ON routing_public.domain_events (updated_at);