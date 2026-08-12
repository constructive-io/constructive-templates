-- Revert: schemas/routing_public/tables/site_deep_links/columns/updated_at/column


ALTER TABLE routing_public.site_deep_links 
  DROP COLUMN updated_at RESTRICT;