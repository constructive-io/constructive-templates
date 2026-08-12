-- Revert: schemas/routing_public/tables/api_settings/columns/enable_connection_filter/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN enable_connection_filter RESTRICT;