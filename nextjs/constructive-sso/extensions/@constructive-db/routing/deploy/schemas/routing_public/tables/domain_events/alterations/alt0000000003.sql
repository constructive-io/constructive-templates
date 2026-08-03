-- Deploy: schemas/routing_public/tables/domain_events/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table


COMMENT ON TABLE routing_public.domain_events IS '@scope database
@scopeKey database_id
@scopeTier database
Audit trail of domain lifecycle events';