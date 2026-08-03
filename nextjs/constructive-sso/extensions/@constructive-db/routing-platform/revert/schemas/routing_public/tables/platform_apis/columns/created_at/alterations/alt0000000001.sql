-- Revert: schemas/routing_public/tables/platform_apis/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN created_at DROP DEFAULT;