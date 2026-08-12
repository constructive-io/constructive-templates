-- Revert: schemas/routing_public/tables/site_deep_links/constraints/site_deep_links_site_id_slug_key/constraint


ALTER TABLE routing_public.site_deep_links 
  DROP CONSTRAINT site_deep_links_site_id_slug_key RESTRICT;