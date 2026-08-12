-- Revert: schemas/routing_public/tables/sites/columns/is_published/alterations/alt0000000002


ALTER TABLE routing_public.sites 
  ALTER COLUMN is_published DROP DEFAULT;