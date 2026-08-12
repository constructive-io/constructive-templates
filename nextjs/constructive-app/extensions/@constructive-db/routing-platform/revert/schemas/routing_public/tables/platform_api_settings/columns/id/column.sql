-- Revert: schemas/routing_public/tables/platform_api_settings/columns/id/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN id RESTRICT;