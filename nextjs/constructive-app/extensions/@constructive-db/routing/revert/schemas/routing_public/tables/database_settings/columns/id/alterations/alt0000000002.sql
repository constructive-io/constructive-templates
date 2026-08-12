-- Revert: schemas/routing_public/tables/database_settings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN id DROP DEFAULT;