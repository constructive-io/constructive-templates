-- Revert: schemas/myapp_capabilities_public/tables/app_capabilities/grants/authenticated/insert/grant


REVOKE INSERT ON myapp_capabilities_public.app_capabilities FROM authenticated;


