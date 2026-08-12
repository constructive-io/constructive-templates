-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/is_public/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/is_public/column


COMMENT ON COLUMN myapp_storage_public.app_files.is_public IS E'Whether this file is publicly readable. Inherited from bucket on INSERT.';

