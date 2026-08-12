-- Revert: schemas/routing_public/tables/pages/columns/created_at/alterations/alt0000000002


ALTER TABLE routing_public.pages 
  ALTER COLUMN created_at DROP DEFAULT;