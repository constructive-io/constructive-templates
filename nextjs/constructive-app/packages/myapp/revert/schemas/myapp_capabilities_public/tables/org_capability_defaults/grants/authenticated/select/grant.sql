-- Revert: schemas/myapp_capabilities_public/tables/org_capability_defaults/grants/authenticated/select/grant


REVOKE SELECT ON myapp_capabilities_public.org_capability_defaults FROM authenticated;


