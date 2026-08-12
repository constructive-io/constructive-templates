-- Revert: schemas/routing_public/tables/cors_settings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN updated_at DROP DEFAULT;