-- Deploy: schemas/platform_routing_public/tables/platform_route_bindings/constraints/platform_route_bindings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_route_bindings/table


ALTER TABLE platform_routing_public.platform_route_bindings 
  ADD CONSTRAINT platform_route_bindings_pkey PRIMARY KEY (id);