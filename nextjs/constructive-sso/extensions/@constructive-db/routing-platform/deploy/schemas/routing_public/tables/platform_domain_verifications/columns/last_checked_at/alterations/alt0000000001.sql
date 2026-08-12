-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/last_checked_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/last_checked_at/column


COMMENT ON COLUMN routing_public.platform_domain_verifications.last_checked_at IS 'When this challenge was last probed';