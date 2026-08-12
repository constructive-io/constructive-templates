-- Revert: schemas/routing_public/tables/site_deep_links/columns/metadata/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN metadata RESTRICT;