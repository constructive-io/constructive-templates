-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/parent_hostname/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/parent_hostname/column


COMMENT ON COLUMN routing_public.hostname_bindings.parent_hostname IS 'Parent hostname a wildcard binding covers';