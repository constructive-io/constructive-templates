-- Revert: schemas/myapp_capabilities_public/tables/app_capability_defaults/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_capabilities_public.app_capability_defaults FROM authenticated;


