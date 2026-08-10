-- Revert: schemas/routing_public/tables/pages/columns/created_at/column


ALTER TABLE routing_public.pages 
  DROP COLUMN created_at RESTRICT;