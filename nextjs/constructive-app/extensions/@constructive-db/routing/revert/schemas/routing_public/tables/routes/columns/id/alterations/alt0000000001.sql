-- Revert: schemas/routing_public/tables/routes/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN id DROP NOT NULL;