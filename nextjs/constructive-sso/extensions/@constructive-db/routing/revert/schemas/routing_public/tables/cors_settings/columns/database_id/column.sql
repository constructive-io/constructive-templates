-- Revert: schemas/routing_public/tables/cors_settings/columns/database_id/column


ALTER TABLE routing_public.cors_settings 
  DROP COLUMN database_id RESTRICT;