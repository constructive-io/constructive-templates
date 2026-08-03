-- Revert: schemas/routing_public/tables/api_settings/columns/created_at/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN created_at RESTRICT;