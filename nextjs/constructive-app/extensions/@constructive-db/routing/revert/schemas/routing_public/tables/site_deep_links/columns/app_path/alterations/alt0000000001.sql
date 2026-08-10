-- Revert: schemas/routing_public/tables/site_deep_links/columns/app_path/alterations/alt0000000001


ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN app_path DROP NOT NULL;