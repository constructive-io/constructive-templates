-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/attempts/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/attempts/column


COMMENT ON COLUMN routing_public.platform_domain_verifications.attempts IS 'How many times this challenge has been probed';