-- Revert: schemas/routing_public/tables/site_error_pages/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN id DROP DEFAULT;