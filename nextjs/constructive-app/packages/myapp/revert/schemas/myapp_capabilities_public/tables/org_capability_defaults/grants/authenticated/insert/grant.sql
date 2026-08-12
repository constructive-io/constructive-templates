-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_capabilities_public.org_capability_defaults FROM authenticated;


