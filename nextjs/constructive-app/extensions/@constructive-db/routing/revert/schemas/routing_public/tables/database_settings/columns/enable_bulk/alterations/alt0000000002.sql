-- Revert: schemas/routing_public/tables/database_settings/columns/enable_bulk/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_bulk DROP DEFAULT;