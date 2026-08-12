-- Revert: schemas/routing_public/tables/platform_pages/columns/store_id/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN store_id RESTRICT;