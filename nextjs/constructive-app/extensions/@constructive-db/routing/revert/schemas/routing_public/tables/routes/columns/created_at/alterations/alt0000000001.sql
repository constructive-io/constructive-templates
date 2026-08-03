-- Revert: schemas/routing_public/tables/routes/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.routes 
  ALTER COLUMN created_at DROP DEFAULT;