-- Revert: schemas/routing_public/tables/platform_site_error_pages/columns/object_path/column


ALTER TABLE routing_public.platform_site_error_pages 
  DROP COLUMN object_path RESTRICT;