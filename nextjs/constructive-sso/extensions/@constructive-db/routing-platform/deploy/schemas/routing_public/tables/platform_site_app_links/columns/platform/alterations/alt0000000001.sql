-- Deploy: schemas/routing_public/tables/platform_site_app_links/columns/platform/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/table
-- requires: schemas/routing_public/tables/platform_site_app_links/columns/platform/column


ALTER TABLE routing_public.platform_site_app_links 
  ALTER COLUMN platform SET NOT NULL;