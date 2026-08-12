-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/upload/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/upload/column


COMMENT ON COLUMN myapp_storage_public.app_files.upload IS E'Processed file reference (upload domain). Populated by processing jobs after file is uploaded. Copy this value to other tables to reference the file.';

