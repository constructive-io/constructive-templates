-- Deploy: schemas/routing_public/tables/route_bindings/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table


ALTER TABLE routing_public.route_bindings 
  DISABLE ROW LEVEL SECURITY;