-- Revert: schemas/routing_public/tables/cors_settings/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN id DROP NOT NULL;