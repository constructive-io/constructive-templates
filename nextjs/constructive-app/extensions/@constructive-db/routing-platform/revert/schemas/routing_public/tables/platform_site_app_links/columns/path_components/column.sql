-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/path_components/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN path_components RESTRICT;