-- Revert: schemas/routing_public/tables/routes/columns/updated_at/column


ALTER TABLE routing_public.routes 
  DROP COLUMN updated_at RESTRICT;