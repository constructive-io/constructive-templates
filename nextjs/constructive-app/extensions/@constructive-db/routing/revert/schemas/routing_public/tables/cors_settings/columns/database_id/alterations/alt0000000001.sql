-- Revert: schemas/routing_public/tables/cors_settings/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN database_id DROP NOT NULL;