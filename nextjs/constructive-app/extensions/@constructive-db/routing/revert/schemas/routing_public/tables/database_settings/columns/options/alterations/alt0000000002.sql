-- Revert: schemas/routing_public/tables/database_settings/columns/options/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN options DROP DEFAULT;