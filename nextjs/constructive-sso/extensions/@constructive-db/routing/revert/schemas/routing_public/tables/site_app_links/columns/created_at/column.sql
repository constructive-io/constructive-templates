-- Revert: schemas/routing_public/tables/site_app_links/columns/created_at/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN created_at RESTRICT;