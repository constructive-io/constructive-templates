-- Revert: schemas/routing_public/tables/pages/columns/slug/column


ALTER TABLE routing_public.pages 
  DROP COLUMN slug RESTRICT;