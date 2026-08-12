-- Revert: schemas/routing_public/tables/apis/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.apis 
  ALTER COLUMN id DROP DEFAULT;