-- Revert: schemas/routing_public/tables/api_settings/columns/enable_i18n/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN enable_i18n RESTRICT;