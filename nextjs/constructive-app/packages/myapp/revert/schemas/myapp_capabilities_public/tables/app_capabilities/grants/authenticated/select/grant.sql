-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/grants/authenticated/select/grant


REVOKE SELECT ON myapp_capabilities_public.app_capabilities FROM authenticated;


