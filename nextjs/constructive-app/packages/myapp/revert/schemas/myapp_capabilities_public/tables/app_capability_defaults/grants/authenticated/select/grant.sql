-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/grants/authenticated/select/grant


REVOKE SELECT ON myapp_capabilities_public.app_capability_defaults FROM authenticated;


