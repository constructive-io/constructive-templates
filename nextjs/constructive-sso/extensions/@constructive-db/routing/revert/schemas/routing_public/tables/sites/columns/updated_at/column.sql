-- Revert: schemas/routing_public/tables/sites/columns/updated_at/column


ALTER TABLE routing_public.sites 
  DROP COLUMN updated_at RESTRICT;