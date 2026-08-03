-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/priority/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/priority/column


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN priority SET DEFAULT 0;