-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/tls_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/tls_status/column


COMMENT ON COLUMN routing_public.hostname_bindings.tls_status IS 'Certificate lifecycle state compiled from the domain row';