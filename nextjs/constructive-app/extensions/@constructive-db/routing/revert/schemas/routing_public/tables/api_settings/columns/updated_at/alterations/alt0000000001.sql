-- Revert: schemas/routing_public/tables/api_settings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.api_settings 
  ALTER COLUMN updated_at DROP DEFAULT;