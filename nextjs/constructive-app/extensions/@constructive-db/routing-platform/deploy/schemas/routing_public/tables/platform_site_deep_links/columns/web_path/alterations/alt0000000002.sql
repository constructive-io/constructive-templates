-- Deploy: schemas/routing_public/tables/platform_site_deep_links/columns/web_path/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/table
-- requires: schemas/routing_public/tables/platform_site_deep_links/columns/web_path/column
-- requires: schemas/routing_public/tables/platform_site_deep_links/columns/fallback_url/column


ALTER TABLE routing_public.platform_site_deep_links 
  ADD CONSTRAINT platform_site_deep_links_web_path_fallback_url_chk 
    CHECK (num_nonnulls(web_path, fallback_url) = 1);