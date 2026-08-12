-- Deploy: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/column
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table


ALTER TABLE platform_routing_public.platform_routes 
  ADD COLUMN domain_id uuid;