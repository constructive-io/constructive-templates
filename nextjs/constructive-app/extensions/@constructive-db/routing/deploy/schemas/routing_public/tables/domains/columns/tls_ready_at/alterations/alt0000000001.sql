-- Deploy: schemas/routing_public/tables/domains/columns/tls_ready_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/columns/tls_ready_at/column


COMMENT ON COLUMN routing_public.domains.tls_ready_at IS 'When the certificate last became ready';