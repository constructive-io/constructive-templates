-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/content_hash/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/content_hash/column


COMMENT ON COLUMN myapp_storage_public.app_files.content_hash IS E'SHA-256 content hash for integrity verification and dedup. In default mode, equals the S3 key. In custom key mode, stored separately.';

