-- Revert: schemas/myapp_store_public/procedures/app_internal_secrets_rotate/grants/authenticated


REVOKE EXECUTE ON FUNCTION myapp_store_public.app_internal_secrets_rotate FROM authenticated;


