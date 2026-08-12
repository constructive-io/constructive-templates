-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/domain_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/domain_id/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.domain_id IS 'Domain row this binding was compiled from';