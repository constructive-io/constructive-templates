-- Revert: schemas/routing_public/tables/sites/columns/name/column


ALTER TABLE routing_public.sites 
  DROP COLUMN name RESTRICT;