-- Deploy: schemas/routing_public/tables/route_bindings/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table
-- requires: schemas/routing_public/tables/route_bindings/columns/id/column


ALTER TABLE routing_public.route_bindings 
  ALTER COLUMN id SET DEFAULT uuidv7();