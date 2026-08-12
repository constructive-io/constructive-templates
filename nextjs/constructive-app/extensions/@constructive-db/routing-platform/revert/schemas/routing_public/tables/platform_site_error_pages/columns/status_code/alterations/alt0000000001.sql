-- Revert: schemas/routing_public/tables/platform_site_error_pages/columns/status_code/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_error_pages 
  ALTER COLUMN status_code DROP NOT NULL;