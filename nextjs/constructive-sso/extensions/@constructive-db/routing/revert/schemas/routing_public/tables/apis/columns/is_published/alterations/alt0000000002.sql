-- Revert: schemas/routing_public/tables/apis/columns/is_published/alterations/alt0000000002


ALTER TABLE routing_public.apis 
  ALTER COLUMN is_published DROP DEFAULT;