-- Revert: schemas/routing_public/tables/routes/columns/method/column


ALTER TABLE routing_public.routes 
  DROP COLUMN method RESTRICT;