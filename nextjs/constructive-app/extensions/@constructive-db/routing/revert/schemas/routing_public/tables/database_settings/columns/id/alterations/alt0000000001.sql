-- Revert: schemas/routing_public/tables/database_settings/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN id DROP NOT NULL;