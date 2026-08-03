-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/verification_status/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/verification_status/column


COMMENT ON COLUMN routing_public.hostname_bindings.verification_status IS 'Ownership verification state compiled from the domain row';