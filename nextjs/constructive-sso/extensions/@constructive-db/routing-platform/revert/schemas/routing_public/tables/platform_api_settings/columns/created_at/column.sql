-- Revert: schemas/routing_public/tables/platform_api_settings/columns/created_at/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN created_at RESTRICT;