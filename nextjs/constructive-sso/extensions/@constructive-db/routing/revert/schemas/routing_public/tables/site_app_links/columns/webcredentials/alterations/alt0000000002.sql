-- Revert: schemas/routing_public/tables/site_app_links/columns/webcredentials/alterations/alt0000000002


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN webcredentials DROP DEFAULT;