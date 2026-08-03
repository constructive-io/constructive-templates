-- Deploy: schemas/routing_public/tables/domain_events/columns/domain_verification_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/columns/domain_verification_id/column


COMMENT ON COLUMN routing_public.domain_events.domain_verification_id IS 'Verification challenge this event relates to, if any';