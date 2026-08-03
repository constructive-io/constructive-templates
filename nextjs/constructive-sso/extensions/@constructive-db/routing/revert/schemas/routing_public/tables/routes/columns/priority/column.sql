-- Revert: schemas/routing_public/tables/routes/columns/priority/column


ALTER TABLE routing_public.routes 
  DROP COLUMN priority RESTRICT;