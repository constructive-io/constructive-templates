-- Revert: schemas/routing_public/tables/site_app_links/columns/updated_at/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN updated_at RESTRICT;