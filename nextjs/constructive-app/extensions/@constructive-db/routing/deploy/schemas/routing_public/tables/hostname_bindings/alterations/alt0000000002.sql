-- Deploy: schemas/routing_public/tables/hostname_bindings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/hostname_bindings/table


COMMENT ON TABLE routing_public.hostname_bindings IS 'Compiled hostname index maintained by domain sync triggers; read only through the resolver';