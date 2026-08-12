-- Revert: schemas/routing_public/tables/platform_pages/columns/updated_at/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN updated_at RESTRICT;