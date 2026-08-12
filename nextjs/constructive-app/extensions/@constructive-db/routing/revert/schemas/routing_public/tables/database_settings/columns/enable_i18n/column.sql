-- Revert: schemas/routing_public/tables/database_settings/columns/enable_i18n/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_i18n RESTRICT;