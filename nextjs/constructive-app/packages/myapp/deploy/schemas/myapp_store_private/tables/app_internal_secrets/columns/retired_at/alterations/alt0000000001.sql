-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/retired_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/retired_at/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.retired_at IS E'When this secret version was retired by rotation. NULL = active. Only one active secret per (namespace_id, name) is allowed via partial unique index.';

