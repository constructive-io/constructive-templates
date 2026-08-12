-- Revert: schemas/routing_public/tables/cors_settings/columns/allowed_origins/alterations/alt0000000002


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN allowed_origins DROP DEFAULT;