-- Deploy: schemas/routing_public/tables/domain_events/columns/domain_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/columns/domain_id/column


COMMENT ON COLUMN routing_public.domain_events.domain_id IS 'Scoped domain this event belongs to';