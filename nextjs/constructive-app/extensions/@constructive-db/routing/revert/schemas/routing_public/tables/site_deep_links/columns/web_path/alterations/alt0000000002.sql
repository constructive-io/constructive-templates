-- Revert: schemas/routing_public/tables/site_deep_links/columns/web_path/alterations/alt0000000002


ALTER TABLE routing_public.site_deep_links 
  DROP CONSTRAINT site_deep_links_web_path_fallback_url_chk RESTRICT;