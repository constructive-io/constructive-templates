-- Revert: schemas/routing_public/tables/api_settings/columns/enable_presigned_uploads/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN enable_presigned_uploads RESTRICT;