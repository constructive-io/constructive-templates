-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/grants/authenticated/select/grant


REVOKE SELECT ON myapp_capabilities_public.org_capabilities FROM authenticated;


