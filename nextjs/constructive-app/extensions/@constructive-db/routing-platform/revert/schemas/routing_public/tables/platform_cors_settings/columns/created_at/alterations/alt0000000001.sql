-- Revert: schemas/routing_public/tables/platform_cors_settings/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_cors_settings 
  ALTER COLUMN created_at DROP DEFAULT;