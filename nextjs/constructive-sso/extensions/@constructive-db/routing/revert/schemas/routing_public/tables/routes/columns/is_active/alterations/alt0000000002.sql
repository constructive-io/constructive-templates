-- Revert: schemas/routing_public/tables/routes/columns/is_active/alterations/alt0000000002


ALTER TABLE routing_public.routes 
  ALTER COLUMN is_active DROP DEFAULT;