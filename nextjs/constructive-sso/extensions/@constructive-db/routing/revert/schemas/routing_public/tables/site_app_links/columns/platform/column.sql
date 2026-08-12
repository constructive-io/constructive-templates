-- Revert: schemas/routing_public/tables/site_app_links/columns/platform/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN platform RESTRICT;