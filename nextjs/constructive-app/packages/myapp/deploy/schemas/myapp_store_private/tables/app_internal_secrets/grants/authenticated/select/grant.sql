-- Deploy: schemas/myapp_store_private/tables/app_internal_secrets/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_private/schema
-- requires: schemas/myapp_store_private/tables/app_internal_secrets/table


GRANT SELECT ON myapp_store_private.app_internal_secrets TO authenticated;

