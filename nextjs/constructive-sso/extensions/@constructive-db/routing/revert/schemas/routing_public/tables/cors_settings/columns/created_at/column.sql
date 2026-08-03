-- Revert: schemas/routing_public/tables/cors_settings/columns/created_at/column


ALTER TABLE routing_public.cors_settings 
  DROP COLUMN created_at RESTRICT;