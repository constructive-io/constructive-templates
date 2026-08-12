-- Revert: schemas/routing_public/tables/database_settings/columns/enable_i18n/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_i18n DROP DEFAULT;