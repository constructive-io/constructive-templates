-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/id/column


ALTER TABLE routing_public.platform_site_deep_links 
  DROP COLUMN id RESTRICT;