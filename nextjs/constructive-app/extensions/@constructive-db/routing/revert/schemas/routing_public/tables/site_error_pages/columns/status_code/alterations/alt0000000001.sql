-- Revert: schemas/routing_public/tables/site_error_pages/columns/status_code/alterations/alt0000000001


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN status_code DROP NOT NULL;