-- Revert: schemas/routing_public/tables/routes/columns/is_active/column


ALTER TABLE routing_public.routes 
  DROP COLUMN is_active RESTRICT;