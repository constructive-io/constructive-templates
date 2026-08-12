-- Revert: schemas/routing_public/tables/platform_apis/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN updated_at DROP DEFAULT;