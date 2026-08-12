-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/slug/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_deep_links 
  ALTER COLUMN slug DROP NOT NULL;