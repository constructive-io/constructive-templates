-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/status/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/status/column


COMMENT ON COLUMN myapp_storage_public.app_files.status IS E'File lifecycle status: requested (presigned URL generated, not yet in S3), uploaded (file in S3 and content validated, ready for use), processed (image resized, text extracted, embedding computed), rejected (declared type disagreed with the bytes), expired (bytes never arrived before the confirm window closed).';

