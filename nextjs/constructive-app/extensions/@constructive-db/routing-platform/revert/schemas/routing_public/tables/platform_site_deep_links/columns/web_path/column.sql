-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/web_path/column


ALTER TABLE routing_public.platform_site_deep_links 
  DROP COLUMN web_path RESTRICT;