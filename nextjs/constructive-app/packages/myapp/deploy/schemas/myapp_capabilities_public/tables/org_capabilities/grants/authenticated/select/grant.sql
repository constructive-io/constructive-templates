-- Deploy: schemas/myapp_capabilities_public/tables/org_capabilities/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/org_capabilities/table


GRANT SELECT ON myapp_capabilities_public.org_capabilities TO authenticated;

