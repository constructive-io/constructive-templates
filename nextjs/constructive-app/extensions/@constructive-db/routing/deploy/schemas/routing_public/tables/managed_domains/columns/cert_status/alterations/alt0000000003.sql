-- Deploy: schemas/routing_public/tables/managed_domains/columns/cert_status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/managed_domains/columns/cert_status/column


COMMENT ON COLUMN routing_public.managed_domains.cert_status IS 'Certificate issuance state for this managed hostname';