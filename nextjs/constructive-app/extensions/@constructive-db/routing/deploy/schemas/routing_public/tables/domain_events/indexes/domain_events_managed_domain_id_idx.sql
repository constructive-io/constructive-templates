-- Deploy: schemas/routing_public/tables/domain_events/indexes/domain_events_managed_domain_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/domain_events/columns/managed_domain_id/column


CREATE INDEX domain_events_managed_domain_id_idx ON routing_public.domain_events (managed_domain_id);