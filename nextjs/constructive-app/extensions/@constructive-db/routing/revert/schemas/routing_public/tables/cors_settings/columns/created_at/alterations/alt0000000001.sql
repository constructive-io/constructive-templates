-- Revert: schemas/routing_public/tables/cors_settings/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN created_at DROP DEFAULT;