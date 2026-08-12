-- Revert: schemas/routing_public/tables/site_error_pages/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN site_id DROP NOT NULL;