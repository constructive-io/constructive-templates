-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_deep_links 
  ALTER COLUMN created_at DROP DEFAULT;