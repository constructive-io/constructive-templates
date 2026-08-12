-- Revert: schemas/routing_public/tables/sites/columns/id/column


ALTER TABLE routing_public.sites 
  DROP COLUMN id RESTRICT;