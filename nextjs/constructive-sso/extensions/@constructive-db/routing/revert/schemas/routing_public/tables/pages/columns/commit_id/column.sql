-- Revert: schemas/routing_public/tables/pages/columns/commit_id/column


ALTER TABLE routing_public.pages 
  DROP COLUMN commit_id RESTRICT;