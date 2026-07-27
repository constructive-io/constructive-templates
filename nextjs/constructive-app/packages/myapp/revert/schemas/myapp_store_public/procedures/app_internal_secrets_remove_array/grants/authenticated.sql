-- Revert: schemas/myapp_store_public/procedures/app_internal_secrets_remove_array/grants/authenticated


REVOKE EXECUTE ON FUNCTION myapp_store_public.app_internal_secrets_remove_array FROM authenticated;


