-- Revert: schemas/routing_public/tables/site_error_pages/columns/id/column


ALTER TABLE routing_public.site_error_pages 
  DROP COLUMN id RESTRICT;