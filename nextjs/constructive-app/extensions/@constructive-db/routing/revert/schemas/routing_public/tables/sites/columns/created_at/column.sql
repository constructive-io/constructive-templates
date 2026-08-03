-- Revert: schemas/routing_public/tables/sites/columns/created_at/column


ALTER TABLE routing_public.sites 
  DROP COLUMN created_at RESTRICT;