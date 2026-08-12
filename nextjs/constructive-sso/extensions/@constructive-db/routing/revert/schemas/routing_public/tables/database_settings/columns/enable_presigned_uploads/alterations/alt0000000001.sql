-- Revert: schemas/routing_public/tables/database_settings/columns/enable_presigned_uploads/alterations/alt0000000001


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_presigned_uploads DROP NOT NULL;