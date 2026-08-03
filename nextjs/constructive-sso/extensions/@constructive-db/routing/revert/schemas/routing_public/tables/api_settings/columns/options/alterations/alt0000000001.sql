-- Revert: schemas/routing_public/tables/api_settings/columns/options/alterations/alt0000000001


ALTER TABLE routing_public.api_settings 
  ALTER COLUMN options DROP NOT NULL;