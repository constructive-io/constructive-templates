-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/platform/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN platform RESTRICT;