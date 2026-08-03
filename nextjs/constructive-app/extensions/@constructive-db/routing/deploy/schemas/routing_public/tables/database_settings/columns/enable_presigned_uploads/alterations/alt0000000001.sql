-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_presigned_uploads/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table
-- requires: schemas/routing_public/tables/database_settings/columns/enable_presigned_uploads/column


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_presigned_uploads SET NOT NULL;