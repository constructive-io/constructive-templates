-- Revert: schemas/routing_public/tables/site_error_pages/columns/updated_at/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN updated_at RESTRICT;