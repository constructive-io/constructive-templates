-- Revert: schemas/routing_public/tables/routes/columns/created_at/column


ALTER TABLE routing_public.routes 
  DROP COLUMN created_at RESTRICT;