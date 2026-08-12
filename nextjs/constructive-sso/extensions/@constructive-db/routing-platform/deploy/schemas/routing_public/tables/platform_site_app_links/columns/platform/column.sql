-- Deploy: schemas/routing_public/tables/platform_site_app_links/columns/platform/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/table


ALTER TABLE routing_public.platform_site_app_links 
  ADD COLUMN platform text;