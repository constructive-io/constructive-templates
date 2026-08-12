-- Revert: schemas/routing_public/tables/cors_settings/columns/api_id/column


ALTER TABLE routing_public.cors_settings 
  DROP COLUMN api_id RESTRICT;