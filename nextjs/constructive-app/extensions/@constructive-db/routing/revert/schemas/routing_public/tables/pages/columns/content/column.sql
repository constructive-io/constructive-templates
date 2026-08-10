-- Revert: schemas/routing_public/tables/pages/columns/content/column


ALTER TABLE routing_public.pages 
  DROP COLUMN content RESTRICT;