-- Revert: schemas/routing_public/tables/platform_api_settings/columns/updated_at/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN updated_at RESTRICT;