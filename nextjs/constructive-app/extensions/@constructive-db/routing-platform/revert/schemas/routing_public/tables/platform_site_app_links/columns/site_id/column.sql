-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/site_id/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN site_id RESTRICT;