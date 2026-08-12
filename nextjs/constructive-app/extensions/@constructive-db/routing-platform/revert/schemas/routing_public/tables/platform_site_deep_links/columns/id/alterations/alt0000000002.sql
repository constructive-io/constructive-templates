-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_deep_links 
  ALTER COLUMN id DROP DEFAULT;