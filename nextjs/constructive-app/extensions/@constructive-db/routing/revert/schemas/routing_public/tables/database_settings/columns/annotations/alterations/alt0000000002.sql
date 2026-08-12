-- Revert: schemas/routing_public/tables/database_settings/columns/annotations/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN annotations DROP DEFAULT;