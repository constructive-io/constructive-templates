-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/hostname/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/hostname/column


COMMENT ON COLUMN routing_public.hostname_bindings.hostname IS 'Lowercase hostname (exact or *.parent wildcard)';