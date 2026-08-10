-- Revert: schemas/routing_public/tables/site_deep_links/columns/created_at/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN created_at RESTRICT;