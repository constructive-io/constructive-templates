-- Revert: schemas/routing_public/tables/site_deep_links/columns/fallback_url/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN fallback_url RESTRICT;