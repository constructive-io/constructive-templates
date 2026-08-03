-- Revert: schemas/routing_public/tables/database_settings/columns/updated_at/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN updated_at RESTRICT;