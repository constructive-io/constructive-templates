-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/parent_hostname/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/parent_hostname/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.parent_hostname IS 'Parent hostname a wildcard binding covers';