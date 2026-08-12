-- Revert: schemas/routing_public/tables/database_settings/columns/enable_direct_uploads/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_direct_uploads RESTRICT;