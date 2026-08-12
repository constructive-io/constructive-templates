-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table


GRANT DELETE ON myapp_capabilities_public.app_capabilities TO authenticated;

