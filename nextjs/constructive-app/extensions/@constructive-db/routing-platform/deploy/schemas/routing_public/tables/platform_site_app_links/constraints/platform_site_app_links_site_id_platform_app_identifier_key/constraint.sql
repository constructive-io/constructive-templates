-- Deploy: schemas/routing_public/tables/platform_site_app_links/constraints/platform_site_app_links_site_id_platform_app_identifier_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/table


ALTER TABLE routing_public.platform_site_app_links 
  ADD CONSTRAINT platform_site_app_links_site_id_platform_app_identifier_key 
    UNIQUE (site_id, platform, app_identifier);