-- Revert: schemas/routing_public/tables/routes/columns/path/alterations/alt0000000002


ALTER TABLE routing_public.routes 
  ALTER COLUMN path DROP DEFAULT;