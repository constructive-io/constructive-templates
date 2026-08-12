-- Revert: schemas/routing_public/tables/site_error_pages/columns/object_path/alterations/alt0000000001


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN object_path DROP NOT NULL;