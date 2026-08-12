-- Deploy: schemas/routing_public/tables/domain_events/columns/event_type/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/columns/event_type/column


COMMENT ON COLUMN routing_public.domain_events.event_type IS 'Lifecycle event discriminator';