-- Revert: schemas/routing_public/tables/site_app_links/constraints/site_app_links_pkey/constraint


ALTER TABLE routing_public.site_app_links 
  DROP CONSTRAINT site_app_links_pkey RESTRICT;