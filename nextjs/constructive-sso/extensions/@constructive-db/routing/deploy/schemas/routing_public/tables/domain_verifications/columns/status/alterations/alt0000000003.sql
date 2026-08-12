-- Deploy: schemas/routing_public/tables/domain_verifications/columns/status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/columns/status/column


COMMENT ON COLUMN routing_public.domain_verifications.status IS 'Challenge state';