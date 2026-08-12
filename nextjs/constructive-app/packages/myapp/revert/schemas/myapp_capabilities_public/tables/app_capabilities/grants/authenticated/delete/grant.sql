-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/grants/authenticated/delete/grant


REVOKE DELETE ON myapp_capabilities_public.app_capabilities FROM authenticated;


