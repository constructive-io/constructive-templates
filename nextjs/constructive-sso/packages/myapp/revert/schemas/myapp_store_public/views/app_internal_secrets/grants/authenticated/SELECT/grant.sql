-- Revert: schemas/myapp_store_public/views/app_internal_secrets/grants/authenticated/SELECT/grant


REVOKE SELECT ON myapp_store_public.app_internal_secrets FROM authenticated;


