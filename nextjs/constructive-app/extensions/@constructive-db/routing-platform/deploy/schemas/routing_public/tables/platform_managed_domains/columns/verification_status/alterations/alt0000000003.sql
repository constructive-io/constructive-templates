-- Deploy: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_managed_domains/columns/verification_status/column


COMMENT ON COLUMN routing_public.platform_managed_domains.verification_status IS 'DNS ownership verification state of this managed hostname';