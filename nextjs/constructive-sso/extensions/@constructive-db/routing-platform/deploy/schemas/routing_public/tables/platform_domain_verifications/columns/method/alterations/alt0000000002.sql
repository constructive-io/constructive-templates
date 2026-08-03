-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/method/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/method/column


COMMENT ON COLUMN routing_public.platform_domain_verifications.method IS 'Verification method (dns-txt, http-token, …)';