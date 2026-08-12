-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/slug/column


ALTER TABLE routing_public.platform_site_deep_links 
  DROP COLUMN slug RESTRICT;