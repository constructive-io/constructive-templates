-- Revert: schemas/routing_public/tables/site_deep_links/columns/database_id/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN database_id RESTRICT;