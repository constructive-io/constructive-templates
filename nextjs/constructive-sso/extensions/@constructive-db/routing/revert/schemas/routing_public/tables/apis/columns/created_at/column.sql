-- Revert: schemas/routing_public/tables/apis/columns/created_at/column


ALTER TABLE routing_public.apis 
  DROP COLUMN created_at RESTRICT;