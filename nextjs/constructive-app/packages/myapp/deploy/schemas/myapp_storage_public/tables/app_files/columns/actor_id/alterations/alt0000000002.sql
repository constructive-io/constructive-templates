-- Deploy: schemas/myapp_storage_public/tables/app_files/columns/actor_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema
-- requires: schemas/myapp_storage_public/tables/app_files/columns/actor_id/column


COMMENT ON COLUMN myapp_storage_public.app_files.actor_id IS E'User who uploaded this file. Forced to current_user_id() on INSERT. Used for UPDATE/DELETE authorization.';

