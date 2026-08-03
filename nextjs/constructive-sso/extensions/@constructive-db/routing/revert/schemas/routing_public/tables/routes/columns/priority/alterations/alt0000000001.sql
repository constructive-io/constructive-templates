-- Revert: schemas/routing_public/tables/routes/columns/priority/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN priority DROP NOT NULL;