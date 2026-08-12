-- Revert: schemas/routing_public/tables/pages/columns/updated_at/column


ALTER TABLE routing_public.pages 
  DROP COLUMN updated_at RESTRICT;