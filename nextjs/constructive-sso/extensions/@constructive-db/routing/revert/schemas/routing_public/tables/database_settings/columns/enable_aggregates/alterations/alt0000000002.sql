-- Revert: schemas/routing_public/tables/database_settings/columns/enable_aggregates/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_aggregates DROP DEFAULT;