-- Deploy: schemas/routing_public/tables/domain_verifications/columns/record_type/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/columns/record_type/column


COMMENT ON COLUMN routing_public.domain_verifications.record_type IS 'DNS record type the challenge expects';