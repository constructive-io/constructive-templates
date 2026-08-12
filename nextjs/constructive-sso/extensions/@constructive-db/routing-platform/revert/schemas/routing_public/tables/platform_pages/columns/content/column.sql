-- Revert: schemas/routing_public/tables/platform_pages/columns/content/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN content RESTRICT;