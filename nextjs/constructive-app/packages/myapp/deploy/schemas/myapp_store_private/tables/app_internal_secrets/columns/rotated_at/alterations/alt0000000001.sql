-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/rotated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/rotated_at/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.rotated_at IS E'When this secret version was created by a rotation operation. NULL for secrets created directly (not via rotation).';

