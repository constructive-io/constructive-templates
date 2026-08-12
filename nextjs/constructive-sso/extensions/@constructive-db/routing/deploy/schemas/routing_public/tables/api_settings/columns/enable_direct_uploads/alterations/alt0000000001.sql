-- Deploy: schemas/routing_public/tables/api_settings/columns/enable_direct_uploads/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/columns/enable_direct_uploads/column


COMMENT ON COLUMN routing_public.api_settings.enable_direct_uploads IS 'Override: enable direct (multipart) file uploads (NULL = inherit from database_settings)';