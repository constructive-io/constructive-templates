-- Revert: schemas/routing_public/tables/platform_pages/columns/slug/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN slug RESTRICT;