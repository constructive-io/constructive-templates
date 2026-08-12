-- Revert: schemas/routing_public/tables/cors_settings/columns/updated_at/column


ALTER TABLE routing_public.cors_settings 
  DROP COLUMN updated_at RESTRICT;