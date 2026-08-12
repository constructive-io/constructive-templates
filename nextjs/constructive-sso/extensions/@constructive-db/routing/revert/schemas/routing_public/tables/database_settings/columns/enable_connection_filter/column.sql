-- Revert: schemas/routing_public/tables/database_settings/columns/enable_connection_filter/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_connection_filter RESTRICT;