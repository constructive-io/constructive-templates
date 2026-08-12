-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


GRANT DELETE ON myapp_memberships_public.app_capability_default_capabilities TO authenticated;

