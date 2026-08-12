-- Deploy: schemas/routing_public/tables/platform_site_deep_links/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/table


ALTER TABLE routing_public.platform_site_deep_links 
  ADD COLUMN updated_at timestamptz;