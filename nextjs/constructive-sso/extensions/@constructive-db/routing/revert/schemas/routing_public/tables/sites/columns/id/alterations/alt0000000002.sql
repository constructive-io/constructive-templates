-- Revert: schemas/routing_public/tables/sites/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.sites 
  ALTER COLUMN id DROP DEFAULT;