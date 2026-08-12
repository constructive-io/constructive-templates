-- Revert: schemas/routing_public/tables/platform_apis/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN id DROP DEFAULT;