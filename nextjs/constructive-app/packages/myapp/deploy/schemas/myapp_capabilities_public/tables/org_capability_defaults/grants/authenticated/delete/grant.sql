-- Deploy: schemas/myapp_capabilities_public/tables/org_capability_defaults/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capability_defaults/table


GRANT DELETE ON myapp_capabilities_public.org_capability_defaults TO authenticated;

