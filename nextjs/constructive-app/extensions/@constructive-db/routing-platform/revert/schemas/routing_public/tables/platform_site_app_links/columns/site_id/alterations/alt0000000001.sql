-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_app_links 
  ALTER COLUMN site_id DROP NOT NULL;