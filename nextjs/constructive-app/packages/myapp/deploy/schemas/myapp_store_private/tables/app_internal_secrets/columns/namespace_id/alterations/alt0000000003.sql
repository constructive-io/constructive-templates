-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/columns/namespace_id/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/columns/namespace_id/column


COMMENT ON COLUMN myapp_store_private.app_internal_secrets.namespace_id IS E'Logical grouping key for internal secret entries; always uuid_nil() for app-scoped internal secrets. Not an FK because internal_secrets_module does not depend on namespace_module.';

