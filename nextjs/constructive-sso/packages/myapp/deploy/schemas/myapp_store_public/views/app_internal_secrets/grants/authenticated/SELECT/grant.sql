-- Deploy: schemas/myapp_store_public/views/app_internal_secrets/grants/authenticated/SELECT/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema
-- requires: schemas/myapp_store_public/views/app_internal_secrets/view


GRANT SELECT ON myapp_store_public.app_internal_secrets TO authenticated;

