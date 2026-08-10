-- Revert: schemas/routing_public/tables/site_deep_links/columns/slug/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN slug RESTRICT;