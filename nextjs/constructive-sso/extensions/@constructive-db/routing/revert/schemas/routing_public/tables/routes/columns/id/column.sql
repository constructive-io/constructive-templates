-- Revert: schemas/routing_public/tables/routes/columns/id/column


ALTER TABLE routing_public.routes 
  DROP COLUMN id RESTRICT;