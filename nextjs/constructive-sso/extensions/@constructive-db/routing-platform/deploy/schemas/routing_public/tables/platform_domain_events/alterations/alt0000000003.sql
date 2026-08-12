-- Deploy: schemas/routing_public/tables/platform_domain_events/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_events/table


COMMENT ON TABLE routing_public.platform_domain_events IS '@scope platform
@scopeTier global
Audit trail of domain lifecycle events';