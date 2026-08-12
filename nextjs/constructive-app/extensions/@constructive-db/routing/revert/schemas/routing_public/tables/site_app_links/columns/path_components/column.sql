-- Revert: schemas/routing_public/tables/site_app_links/columns/path_components/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN path_components RESTRICT;