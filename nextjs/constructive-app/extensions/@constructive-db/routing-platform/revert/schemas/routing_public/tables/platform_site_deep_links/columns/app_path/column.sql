-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/app_path/column


ALTER TABLE routing_public.platform_site_deep_links 
  DROP COLUMN app_path RESTRICT;