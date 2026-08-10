-- Revert: schemas/routing_public/tables/platform_site_deep_links/columns/web_path/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_deep_links 
  DROP CONSTRAINT platform_site_deep_links_web_path_fallback_url_chk RESTRICT;