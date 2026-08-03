-- Revert: schemas/routing_public/tables/database_settings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN updated_at DROP DEFAULT;