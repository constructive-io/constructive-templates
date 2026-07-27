-- Revert: schemas/myapp_store_private/tables/app_internal_secrets/grants/authenticated/select/grant


REVOKE SELECT ON myapp_store_private.app_internal_secrets FROM authenticated;


