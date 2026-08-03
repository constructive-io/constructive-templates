-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/verification_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/verification_status/column


COMMENT ON COLUMN platform_routing_public.platform_hostname_bindings.verification_status IS 'Ownership verification state compiled from the domain row';