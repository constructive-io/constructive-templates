-- Deploy: schemas/routing_public/tables/platform_domains/columns/tls_status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/tls_status/column


COMMENT ON COLUMN routing_public.platform_domains.tls_status IS 'Certificate lifecycle state for this hostname';