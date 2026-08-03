-- Revert: schemas/routing_public/tables/database_settings/columns/id/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN id RESTRICT;