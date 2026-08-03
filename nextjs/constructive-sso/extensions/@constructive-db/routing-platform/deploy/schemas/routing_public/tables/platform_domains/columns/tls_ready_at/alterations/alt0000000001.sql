-- Deploy: schemas/routing_public/tables/platform_domains/columns/tls_ready_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/columns/tls_ready_at/column


COMMENT ON COLUMN routing_public.platform_domains.tls_ready_at IS 'When the certificate last became ready';