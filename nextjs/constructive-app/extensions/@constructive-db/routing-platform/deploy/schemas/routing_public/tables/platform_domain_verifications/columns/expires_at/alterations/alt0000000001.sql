-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/expires_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/expires_at/column


COMMENT ON COLUMN routing_public.platform_domain_verifications.expires_at IS 'When this challenge expires';