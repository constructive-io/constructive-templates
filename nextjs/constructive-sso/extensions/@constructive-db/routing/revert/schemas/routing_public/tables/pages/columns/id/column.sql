-- Revert: schemas/routing_public/tables/pages/columns/id/column


ALTER TABLE routing_public.pages 
  DROP COLUMN id RESTRICT;