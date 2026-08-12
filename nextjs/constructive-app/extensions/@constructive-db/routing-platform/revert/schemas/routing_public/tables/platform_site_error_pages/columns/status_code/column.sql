-- Revert: schemas/routing_public/tables/platform_site_error_pages/columns/status_code/column


ALTER TABLE routing_public.platform_site_error_pages 
  DROP COLUMN status_code RESTRICT;