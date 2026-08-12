-- Revert: schemas/routing_public/tables/site_deep_links/columns/site_id/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN site_id RESTRICT;