-- Deploy: schemas/routing_public/tables/route_bindings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table


COMMENT ON TABLE routing_public.route_bindings IS 'Compiled route precedence index maintained by route sync triggers; carries typed target ids only, read through the resolver';