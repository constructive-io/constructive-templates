-- Deploy: schemas/myapp_capabilities_public/tables/app_capability_defaults/grants/authenticated/insert/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capability_defaults/table


GRANT INSERT ON myapp_capabilities_public.app_capability_defaults TO authenticated;

