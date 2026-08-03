-- Revert: schemas/routing_public/tables/database_settings/columns/database_id/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN database_id RESTRICT;