-- Revert: schemas/routing_public/tables/site_app_links/columns/site_id/column


ALTER TABLE routing_public.site_app_links 
  DROP COLUMN site_id RESTRICT;