-- Revert: schemas/routing_public/tables/apis/columns/id/column


ALTER TABLE routing_public.apis 
  DROP COLUMN id RESTRICT;