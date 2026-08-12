-- Revert: schemas/routing_public/tables/platform_site_error_pages/columns/id/column


ALTER TABLE routing_public.platform_site_error_pages 
  DROP COLUMN id RESTRICT;