-- Revert: schemas/routing_public/tables/site_error_pages/columns/database_id/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN database_id RESTRICT;