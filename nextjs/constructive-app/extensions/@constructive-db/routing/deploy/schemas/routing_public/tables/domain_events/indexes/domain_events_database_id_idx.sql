-- Deploy: schemas/routing_public/tables/domain_events/indexes/domain_events_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/domain_events/columns/database_id/column


CREATE INDEX domain_events_database_id_idx ON routing_public.domain_events (database_id);