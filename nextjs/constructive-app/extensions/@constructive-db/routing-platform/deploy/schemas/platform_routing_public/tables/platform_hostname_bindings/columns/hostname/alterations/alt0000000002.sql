-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/hostname/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/hostname/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.hostname IS 'Lowercase hostname (exact or *.parent wildcard)';