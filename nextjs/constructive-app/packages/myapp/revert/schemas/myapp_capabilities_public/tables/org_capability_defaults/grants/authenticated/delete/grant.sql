-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_capabilities_public.org_capability_defaults FROM authenticated;


