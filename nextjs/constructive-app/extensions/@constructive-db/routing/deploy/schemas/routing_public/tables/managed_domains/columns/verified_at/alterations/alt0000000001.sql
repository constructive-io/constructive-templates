-- Deploy: schemas/routing_public/tables/managed_domains/columns/verified_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/columns/verified_at/column


COMMENT ON COLUMN routing_public.managed_domains.verified_at IS 'When ownership verification last succeeded';