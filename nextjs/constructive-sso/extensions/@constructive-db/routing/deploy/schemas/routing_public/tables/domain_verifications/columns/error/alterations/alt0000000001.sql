-- Deploy: schemas/routing_public/tables/domain_verifications/columns/error/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/columns/error/column


COMMENT ON COLUMN routing_public.domain_verifications.error IS 'Last verification error, if any';