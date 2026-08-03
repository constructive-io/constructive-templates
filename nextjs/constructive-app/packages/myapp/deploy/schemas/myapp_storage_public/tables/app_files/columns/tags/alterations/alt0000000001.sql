-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/tags/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/tags/column


COMMENT ON COLUMN myapp_storage_public.app_files.tags IS E'User-defined tags for categorization and search (mutable)';

