-- Deploy: schemas/routing_public/tables/route_bindings/columns/path/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table


ALTER TABLE routing_public.route_bindings 
  ADD COLUMN path text;