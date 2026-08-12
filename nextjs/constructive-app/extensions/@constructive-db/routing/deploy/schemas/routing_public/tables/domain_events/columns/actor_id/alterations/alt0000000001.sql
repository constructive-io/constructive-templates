-- Deploy: schemas/routing_public/tables/domain_events/columns/actor_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/columns/actor_id/column


COMMENT ON COLUMN routing_public.domain_events.actor_id IS 'User who triggered this event, if any';