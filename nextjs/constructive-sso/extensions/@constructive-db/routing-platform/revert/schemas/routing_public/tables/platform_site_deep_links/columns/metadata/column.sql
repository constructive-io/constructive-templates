-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/metadata/column


ALTER TABLE routing_public.platform_site_deep_links 
  DROP COLUMN metadata RESTRICT;