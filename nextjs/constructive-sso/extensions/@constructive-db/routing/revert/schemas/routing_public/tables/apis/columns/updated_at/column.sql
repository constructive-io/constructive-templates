-- Revert: schemas/routing_public/tables/apis/columns/updated_at/column


ALTER TABLE routing_public.apis 
  DROP COLUMN updated_at RESTRICT;