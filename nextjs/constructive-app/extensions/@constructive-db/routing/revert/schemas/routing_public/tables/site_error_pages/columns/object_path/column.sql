-- Revert: schemas/routing_public/tables/site_error_pages/columns/object_path/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN object_path RESTRICT;