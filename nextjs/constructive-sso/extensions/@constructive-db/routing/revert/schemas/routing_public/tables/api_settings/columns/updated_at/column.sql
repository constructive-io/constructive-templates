-- Revert: schemas/routing_public/tables/api_settings/columns/updated_at/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN updated_at RESTRICT;