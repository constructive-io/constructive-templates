-- Revert: schemas/routing_public/tables/database_settings/columns/enable_many_to_many/alterations/alt0000000002


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_many_to_many DROP DEFAULT;