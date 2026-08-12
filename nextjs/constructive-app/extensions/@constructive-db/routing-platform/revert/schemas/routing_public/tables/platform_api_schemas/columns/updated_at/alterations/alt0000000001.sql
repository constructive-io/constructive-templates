-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_api_schemas 
  ALTER COLUMN updated_at DROP DEFAULT;