-- Deploy: schemas/routing_public/tables/route_bindings/columns/priority/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table
-- requires: schemas/routing_public/tables/route_bindings/columns/priority/column


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN priority SET DEFAULT 0;