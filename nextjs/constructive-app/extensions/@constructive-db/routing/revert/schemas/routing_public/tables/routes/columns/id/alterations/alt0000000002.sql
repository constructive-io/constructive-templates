-- Revert: schemas/routing_public/tables/routes/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.routes 
  ALTER COLUMN id DROP DEFAULT;