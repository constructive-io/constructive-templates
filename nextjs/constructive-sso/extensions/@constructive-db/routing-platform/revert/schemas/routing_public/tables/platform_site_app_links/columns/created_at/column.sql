-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/created_at/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN created_at RESTRICT;