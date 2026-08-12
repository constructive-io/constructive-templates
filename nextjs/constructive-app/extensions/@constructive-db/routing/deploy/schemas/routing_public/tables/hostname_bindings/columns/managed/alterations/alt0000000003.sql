-- Deploy: schemas/routing_public/tables/hostname_bindings/columns/managed/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/columns/managed/column


COMMENT ON COLUMN routing_public.hostname_bindings.managed IS 'Whether the platform drives this hostname''s lifecycle';