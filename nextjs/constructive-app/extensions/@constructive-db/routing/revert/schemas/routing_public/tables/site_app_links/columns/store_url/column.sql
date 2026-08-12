-- Revert: schemas/routing_public/tables/site_app_links/columns/store_url/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN store_url RESTRICT;