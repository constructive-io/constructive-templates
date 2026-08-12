-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


GRANT SELECT ON myapp_memberships_public.app_capability_default_capabilities TO authenticated;

