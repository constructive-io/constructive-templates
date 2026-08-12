-- Revert: schemas/routing_public/tables/platform_cors_settings/columns/allowed_origins/column


ALTER TABLE routing_public.platform_cors_settings 
  DROP COLUMN allowed_origins RESTRICT;