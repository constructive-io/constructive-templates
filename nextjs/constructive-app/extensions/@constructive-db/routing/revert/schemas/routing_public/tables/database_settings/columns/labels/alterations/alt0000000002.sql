-- Revert: schemas/routing_public/tables/database_settings/columns/labels/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN labels DROP DEFAULT;