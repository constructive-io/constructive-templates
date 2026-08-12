-- Deploy: schemas/routing_public/tables/route_bindings/constraints/route_bindings_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table


ALTER TABLE routing_public.route_bindings 
  ADD CONSTRAINT route_bindings_pkey PRIMARY KEY (id);