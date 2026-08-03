-- Revert: schemas/routing_public/tables/apis/columns/is_published/column


ALTER TABLE routing_public.apis 
  DROP COLUMN is_published RESTRICT;