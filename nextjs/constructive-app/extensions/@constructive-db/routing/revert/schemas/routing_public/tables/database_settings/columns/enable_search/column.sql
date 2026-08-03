-- Revert: schemas/routing_public/tables/database_settings/columns/enable_search/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_search RESTRICT;