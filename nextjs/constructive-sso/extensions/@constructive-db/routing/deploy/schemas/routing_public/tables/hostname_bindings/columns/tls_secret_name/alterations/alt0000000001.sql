-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/tls_secret_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/tls_secret_name/column


COMMENT ON COLUMN routing_public.hostname_bindings.tls_secret_name IS 'TLS secret name compiled from the domain row';