-- Revert: schemas/routing_public/tables/routes/columns/path/column


ALTER TABLE routing_public.routes 
  DROP COLUMN path RESTRICT;