-- Deploy: schemas/routing_public/tables/platform_domain_verifications/columns/record_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domain_verifications/columns/record_name/column


COMMENT ON COLUMN routing_public.platform_domain_verifications.record_name IS 'DNS record name the challenge expects';