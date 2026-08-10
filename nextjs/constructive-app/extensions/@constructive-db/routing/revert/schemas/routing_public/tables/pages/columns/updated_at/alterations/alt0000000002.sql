-- Revert: schemas/routing_public/tables/pages/columns/updated_at/alterations/alt0000000002


ALTER TABLE routing_public.pages 
  ALTER COLUMN updated_at DROP DEFAULT;