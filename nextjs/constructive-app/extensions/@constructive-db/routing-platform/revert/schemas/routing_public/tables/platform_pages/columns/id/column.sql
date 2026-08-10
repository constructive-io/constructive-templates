-- Revert: schemas/routing_public/tables/platform_pages/columns/id/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN id RESTRICT;