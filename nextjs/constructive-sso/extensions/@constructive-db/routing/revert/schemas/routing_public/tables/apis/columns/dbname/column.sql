-- Revert: schemas/routing_public/tables/apis/columns/dbname/column


ALTER TABLE routing_public.apis 
  DROP COLUMN dbname RESTRICT;