-- Revert: schemas/routing_public/tables/site_error_pages/columns/status_code/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN status_code RESTRICT;