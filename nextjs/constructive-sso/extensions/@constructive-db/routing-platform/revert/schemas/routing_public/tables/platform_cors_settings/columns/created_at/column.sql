-- Revert: schemas/routing_public/tables/platform_cors_settings/columns/created_at/column


ALTER TABLE routing_public.platform_cors_settings 
  DROP COLUMN created_at RESTRICT;