-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/filename/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/filename/column


COMMENT ON COLUMN myapp_storage_public.app_files.filename IS E'Original filename provided by the uploader. Used for display and Content-Disposition header on download.';

