-- Revert: schemas/routing_public/tables/database_settings/columns/enable_many_to_many/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_many_to_many RESTRICT;