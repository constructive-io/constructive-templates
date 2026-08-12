-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table


COMMENT ON TABLE platform_routing_public.platform_hostname_bindings IS 'Compiled hostname index maintained by domain sync triggers; read only through the resolver';