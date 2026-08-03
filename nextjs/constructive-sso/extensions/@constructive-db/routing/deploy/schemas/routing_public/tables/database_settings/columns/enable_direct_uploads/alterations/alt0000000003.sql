-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_direct_uploads/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_direct_uploads/column


COMMENT ON COLUMN routing_public.database_settings.enable_direct_uploads IS 'Enable direct (multipart) file upload mutations in the GraphQL API';