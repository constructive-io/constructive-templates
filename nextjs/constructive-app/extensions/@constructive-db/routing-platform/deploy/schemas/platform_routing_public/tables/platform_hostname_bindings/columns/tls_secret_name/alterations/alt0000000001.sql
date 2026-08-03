-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/tls_secret_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/tls_secret_name/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.tls_secret_name IS 'TLS secret name compiled from the domain row';