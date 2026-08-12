-- Revert: schemas/routing_public/tables/database_settings/columns/created_at/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN created_at RESTRICT;