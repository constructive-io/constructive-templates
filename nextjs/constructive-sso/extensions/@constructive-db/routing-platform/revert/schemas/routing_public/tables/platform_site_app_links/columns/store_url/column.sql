-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/store_url/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN store_url RESTRICT;