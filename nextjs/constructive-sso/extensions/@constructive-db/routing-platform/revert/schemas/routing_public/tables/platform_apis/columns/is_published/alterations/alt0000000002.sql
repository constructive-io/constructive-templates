-- Revert: schemas/routing_public/tables/platform_apis/columns/is_published/alterations/alt0000000002


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN is_published DROP DEFAULT;