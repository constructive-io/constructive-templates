-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/app_path/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_deep_links 
  ALTER COLUMN app_path DROP NOT NULL;