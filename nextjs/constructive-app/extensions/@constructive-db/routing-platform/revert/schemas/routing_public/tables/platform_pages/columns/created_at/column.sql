-- Revert: schemas/routing_public/tables/platform_pages/columns/created_at/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN created_at RESTRICT;