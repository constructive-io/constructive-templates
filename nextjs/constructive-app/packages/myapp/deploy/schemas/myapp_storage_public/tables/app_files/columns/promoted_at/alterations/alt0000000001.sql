-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/promoted_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/promoted_at/column


COMMENT ON COLUMN myapp_storage_public.app_files.promoted_at IS E'When this file was promoted out of its staging bucket into its destination bucket. NULL for a file that was never staged, or is still staged.';

