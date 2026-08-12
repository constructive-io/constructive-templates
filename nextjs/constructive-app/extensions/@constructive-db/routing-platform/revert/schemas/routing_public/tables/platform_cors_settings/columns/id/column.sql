-- Revert: schemas/routing_public/tables/platform_cors_settings/columns/id/column


ALTER TABLE routing_public.platform_cors_settings 
  DROP COLUMN id RESTRICT;