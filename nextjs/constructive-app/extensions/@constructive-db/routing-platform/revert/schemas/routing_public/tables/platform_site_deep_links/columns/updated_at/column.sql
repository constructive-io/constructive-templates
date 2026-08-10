-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/updated_at/column


ALTER TABLE routing_public.platform_site_deep_links 
  DROP COLUMN updated_at RESTRICT;