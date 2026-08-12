-- Revert: schemas/routing_public/tables/platform_site_app_links/constraints/platform_site_app_links_pkey/constraint


ALTER TABLE routing_public.platform_site_app_links 
  DROP CONSTRAINT platform_site_app_links_pkey RESTRICT;