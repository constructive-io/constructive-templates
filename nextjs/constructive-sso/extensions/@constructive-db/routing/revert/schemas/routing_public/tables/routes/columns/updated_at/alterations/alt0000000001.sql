-- Revert: schemas/routing_public/tables/routes/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN updated_at DROP DEFAULT;