-- Revert: schemas/routing_public/tables/pages/columns/site_id/column


ALTER TABLE routing_public.pages 
  DROP COLUMN site_id RESTRICT;