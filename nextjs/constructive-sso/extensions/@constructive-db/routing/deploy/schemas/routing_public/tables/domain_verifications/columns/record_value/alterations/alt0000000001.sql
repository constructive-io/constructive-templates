-- Deploy: schemas/routing_public/tables/domain_verifications/columns/record_value/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/columns/record_value/column


COMMENT ON COLUMN routing_public.domain_verifications.record_value IS 'DNS record value the challenge expects';