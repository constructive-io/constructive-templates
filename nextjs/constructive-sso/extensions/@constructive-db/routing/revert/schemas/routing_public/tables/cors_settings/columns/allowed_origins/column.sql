-- Revert: schemas/routing_public/tables/cors_settings/columns/allowed_origins/column


ALTER TABLE routing_public.cors_settings 
  DROP COLUMN allowed_origins RESTRICT;