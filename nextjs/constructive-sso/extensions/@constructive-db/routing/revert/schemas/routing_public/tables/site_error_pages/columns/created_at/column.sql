-- Revert: schemas/routing_public/tables/site_error_pages/columns/created_at/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN created_at RESTRICT;