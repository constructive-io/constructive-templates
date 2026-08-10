-- Revert: schemas/routing_public/tables/platform_pages/columns/commit_id/column


ALTER TABLE routing_public.platform_pages 
  DROP COLUMN commit_id RESTRICT;