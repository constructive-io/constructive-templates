-- Revert: schemas/routing_public/tables/platform_site_error_pages/columns/updated_at/column


ALTER TABLE routing_public.platform_site_error_pages 
  DROP COLUMN updated_at RESTRICT;