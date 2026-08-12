-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/webcredentials/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_app_links 
  ALTER COLUMN webcredentials DROP NOT NULL;