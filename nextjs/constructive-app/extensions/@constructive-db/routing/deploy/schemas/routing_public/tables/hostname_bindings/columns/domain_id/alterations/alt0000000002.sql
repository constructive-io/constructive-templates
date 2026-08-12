-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/domain_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/domain_id/column


COMMENT ON COLUMN routing_public.hostname_bindings.domain_id IS 'Domain row this binding was compiled from';