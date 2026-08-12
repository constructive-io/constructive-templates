-- Revert: schemas/routing_public/tables/platform_site_error_pages/columns/created_at/column


ALTER TABLE routing_public.platform_site_error_pages 
  DROP COLUMN created_at RESTRICT;