-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_presigned_uploads/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_presigned_uploads/column


COMMENT ON COLUMN routing_public.database_settings.enable_presigned_uploads IS 'Enable presigned URL upload flow for S3/MinIO storage';