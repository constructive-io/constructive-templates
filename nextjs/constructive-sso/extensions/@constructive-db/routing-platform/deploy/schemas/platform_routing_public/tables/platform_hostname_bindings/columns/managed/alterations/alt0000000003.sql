-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/managed/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/managed/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.managed IS 'Whether the platform drives this hostname''s lifecycle';