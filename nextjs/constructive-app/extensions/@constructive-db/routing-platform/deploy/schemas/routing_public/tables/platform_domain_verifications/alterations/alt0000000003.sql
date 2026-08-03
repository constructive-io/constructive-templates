-- Deploy: schemas/routing_public/tables/platform_domain_verifications/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/table


COMMENT ON TABLE routing_public.platform_domain_verifications IS '@scope platform
@scopeTier global
Ownership verification challenges issued for a domain';