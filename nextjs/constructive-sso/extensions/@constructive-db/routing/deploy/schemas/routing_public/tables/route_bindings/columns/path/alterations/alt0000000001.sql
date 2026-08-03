-- Deploy: schemas/routing_public/tables/route_bindings/columns/path/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table
-- requires: schemas/routing_public/tables/route_bindings/columns/path/column


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN path SET NOT NULL;