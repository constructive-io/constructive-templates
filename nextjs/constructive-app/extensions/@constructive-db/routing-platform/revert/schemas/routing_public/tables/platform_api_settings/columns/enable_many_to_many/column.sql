-- Revert: schemas/routing_public/tables/platform_api_settings/columns/enable_many_to_many/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN enable_many_to_many RESTRICT;