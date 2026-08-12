-- Deploy: schemas/routing_public/tables/platform_pages/columns/commit_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table


ALTER TABLE routing_public.platform_pages 
  ADD COLUMN commit_id uuid;