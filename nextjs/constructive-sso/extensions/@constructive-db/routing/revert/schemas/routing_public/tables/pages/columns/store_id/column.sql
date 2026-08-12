-- Revert: schemas/routing_public/tables/pages/columns/store_id/column


ALTER TABLE routing_public.pages 
  DROP COLUMN store_id RESTRICT;