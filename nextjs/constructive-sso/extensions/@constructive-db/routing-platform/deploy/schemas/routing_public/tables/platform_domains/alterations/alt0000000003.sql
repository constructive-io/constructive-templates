-- Deploy: schemas/routing_public/tables/platform_domains/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table


COMMENT ON TABLE routing_public.platform_domains IS '@scope platform
@scopeTier global
Fully-qualified hostnames owned by this scope; each row claims its hostname globally through the catalog';