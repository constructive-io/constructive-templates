-- Revert: schemas/routing_public/tables/database_settings/columns/enable_presigned_uploads/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_presigned_uploads RESTRICT;