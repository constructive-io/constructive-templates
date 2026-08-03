-- Deploy: schemas/routing_public/tables/platform_domain_events/columns/managed_domain_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/columns/managed_domain_id/column


COMMENT ON COLUMN routing_public.platform_domain_events.managed_domain_id IS 'Managed hostname this event belongs to';