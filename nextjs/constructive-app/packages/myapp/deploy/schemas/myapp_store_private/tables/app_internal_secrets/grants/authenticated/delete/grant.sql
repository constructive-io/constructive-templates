-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


GRANT DELETE ON myapp_store_private.app_internal_secrets TO authenticated;

