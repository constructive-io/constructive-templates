-- Deploy: schemas/routing_public/tables/api_settings/columns/enable_presigned_uploads/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/columns/enable_presigned_uploads/column


COMMENT ON COLUMN routing_public.api_settings.enable_presigned_uploads IS 'Override: enable presigned URL upload flow (NULL = inherit from database_settings)';