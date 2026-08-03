-- Revert: schemas/routing_public/tables/platform_api_settings/columns/api_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_api_settings 
  ALTER COLUMN api_id DROP NOT NULL;