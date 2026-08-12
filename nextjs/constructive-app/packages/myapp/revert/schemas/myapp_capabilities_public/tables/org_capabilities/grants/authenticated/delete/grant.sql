-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_capabilities_public.org_capabilities FROM authenticated;


