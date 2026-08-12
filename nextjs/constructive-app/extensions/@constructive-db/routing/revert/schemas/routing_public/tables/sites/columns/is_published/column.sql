-- Revert: schemas/routing_public/tables/sites/columns/is_published/column


ALTER TABLE routing_public.sites 
  DROP COLUMN is_published RESTRICT;