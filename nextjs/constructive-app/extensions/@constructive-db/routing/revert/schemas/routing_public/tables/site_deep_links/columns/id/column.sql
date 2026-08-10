-- Revert: schemas/routing_public/tables/site_deep_links/columns/id/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN id RESTRICT;