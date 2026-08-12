-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.is_wildcard IS 'Whether this binding is a wildcard claim';