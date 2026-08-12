-- Deploy: schemas/routing_public/tables/platform_sites/columns/installation_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table


ALTER TABLE routing_public.platform_sites 
  ADD COLUMN installation_id uuid;