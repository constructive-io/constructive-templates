-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/id/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN id RESTRICT;