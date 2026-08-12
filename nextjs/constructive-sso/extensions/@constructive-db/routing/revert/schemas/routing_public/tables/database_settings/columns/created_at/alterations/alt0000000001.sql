-- Revert: schemas/routing_public/tables/database_settings/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN created_at DROP DEFAULT;