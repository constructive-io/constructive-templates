-- Deploy: schemas/routing_public/tables/platform_domain_events/indexes/platform_domain_events_domain_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table
-- requires: schemas/routing_public/tables/platform_domain_events/columns/domain_id/column


CREATE INDEX platform_domain_events_domain_id_idx ON routing_public.platform_domain_events (domain_id);