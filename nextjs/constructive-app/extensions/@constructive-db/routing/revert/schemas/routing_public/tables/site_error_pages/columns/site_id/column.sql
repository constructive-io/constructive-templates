-- Revert: schemas/routing_public/tables/site_error_pages/columns/site_id/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN site_id RESTRICT;