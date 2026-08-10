-- Revert: schemas/routing_public/tables/site_app_links/columns/path_components/alterations/alt0000000002


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN path_components DROP DEFAULT;