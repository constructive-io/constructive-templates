-- Revert: schemas/routing_public/tables/platform_site_app_links/columns/app_identifier/column


ALTER TABLE routing_public.platform_site_app_links 
  DROP COLUMN app_identifier RESTRICT;