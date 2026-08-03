-- Revert: schemas/routing_public/tables/api_settings/columns/database_id/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN database_id RESTRICT;