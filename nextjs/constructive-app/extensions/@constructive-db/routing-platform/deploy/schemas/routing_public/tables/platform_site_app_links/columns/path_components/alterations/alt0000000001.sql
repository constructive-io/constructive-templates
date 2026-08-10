-- Deploy: schemas/routing_public/tables/platform_site_app_links/columns/path_components/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/table
-- requires: schemas/routing_public/tables/platform_site_app_links/columns/path_components/column


ALTER TABLE routing_public.platform_site_app_links 
  ALTER COLUMN path_components SET NOT NULL;