-- Deploy: schemas/routing_public/tables/managed_domains/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/table


COMMENT ON TABLE routing_public.managed_domains IS '@scope database
@scopeKey database_id
@scopeTier database
Platform-operated hostnames whose DNS and certificate lifecycle the platform drives';