-- Revert: schemas/routing_public/tables/pages/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.pages 
  ALTER COLUMN id DROP DEFAULT;