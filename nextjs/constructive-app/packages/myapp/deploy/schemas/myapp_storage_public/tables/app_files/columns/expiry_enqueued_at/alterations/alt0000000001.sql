-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/expiry_enqueued_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/expiry_enqueued_at/column


COMMENT ON COLUMN myapp_storage_public.app_files.expiry_enqueued_at IS E'When the staged-expiry sweep enqueued deletion of this file''s object. NULL until it expires; set once so expiry is enqueued exactly once.';

