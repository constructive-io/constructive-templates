-- Revert: schemas/routing_public/tables/sites/columns/title/column


ALTER TABLE routing_public.sites 
  DROP COLUMN title RESTRICT;