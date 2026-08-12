-- Revert: schemas/routing_public/tables/site_error_pages/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN updated_at DROP DEFAULT;