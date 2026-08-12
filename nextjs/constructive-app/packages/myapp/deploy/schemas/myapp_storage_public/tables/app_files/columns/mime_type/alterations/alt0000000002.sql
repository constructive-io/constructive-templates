-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/mime_type/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/mime_type/column


COMMENT ON COLUMN myapp_storage_public.app_files.mime_type IS E'MIME type of the file (e.g. image/png, application/pdf). Immutable after INSERT.';

