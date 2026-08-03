-- Deploy: schemas/routing_public/tables/platform_managed_domains/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/table


COMMENT ON TABLE routing_public.platform_managed_domains IS '@scope platform
@scopeTier global
Platform-operated hostnames whose DNS and certificate lifecycle the platform drives';