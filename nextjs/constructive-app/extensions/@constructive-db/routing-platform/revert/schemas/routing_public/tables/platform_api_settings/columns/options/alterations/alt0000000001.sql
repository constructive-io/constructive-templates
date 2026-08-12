-- Revert: schemas/routing_public/tables/platform_api_settings/columns/options/alterations/alt0000000001


ALTER TABLE routing_public.platform_api_settings 
  ALTER COLUMN options DROP NOT NULL;