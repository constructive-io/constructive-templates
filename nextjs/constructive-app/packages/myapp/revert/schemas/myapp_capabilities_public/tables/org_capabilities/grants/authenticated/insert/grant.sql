-- Revert: schemas/myapp_capabilities_public/tables/org_capabilities/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_capabilities_public.org_capabilities FROM authenticated;


