-- Revert: schemas/routing_public/tables/apis/columns/name/column


ALTER TABLE routing_public.apis 
  DROP COLUMN name RESTRICT;