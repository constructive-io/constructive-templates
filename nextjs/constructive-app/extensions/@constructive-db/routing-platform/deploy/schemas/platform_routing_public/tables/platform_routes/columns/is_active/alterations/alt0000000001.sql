-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/is_active/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/is_active/column


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN is_active SET NOT NULL;