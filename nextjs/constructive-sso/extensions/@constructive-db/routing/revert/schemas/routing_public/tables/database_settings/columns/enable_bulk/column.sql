-- Revert: schemas/routing_public/tables/database_settings/columns/enable_bulk/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_bulk RESTRICT;