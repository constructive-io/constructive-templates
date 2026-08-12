-- Revert: schemas/routing_public/tables/platform_pages/columns/site_id/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN site_id RESTRICT;