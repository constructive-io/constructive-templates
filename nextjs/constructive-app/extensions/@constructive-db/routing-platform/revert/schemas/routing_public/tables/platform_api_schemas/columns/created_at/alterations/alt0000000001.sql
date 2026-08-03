-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_api_schemas 
  ALTER COLUMN created_at DROP DEFAULT;