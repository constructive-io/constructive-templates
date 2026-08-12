-- Deploy: schemas/routing_public/tables/domain_verifications/columns/attempts/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_verifications/columns/attempts/column


COMMENT ON COLUMN routing_public.domain_verifications.attempts IS 'How many times this challenge has been probed';