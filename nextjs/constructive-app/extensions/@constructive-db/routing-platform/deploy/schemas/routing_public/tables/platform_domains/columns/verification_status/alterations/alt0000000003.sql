-- Deploy: schemas/routing_public/tables/platform_domains/columns/verification_status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/verification_status/column


COMMENT ON COLUMN routing_public.platform_domains.verification_status IS 'Ownership verification state of this hostname';