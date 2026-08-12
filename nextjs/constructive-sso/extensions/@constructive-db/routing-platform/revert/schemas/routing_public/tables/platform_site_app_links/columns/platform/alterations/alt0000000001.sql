-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/platform/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_app_links 
  ALTER COLUMN platform DROP NOT NULL;