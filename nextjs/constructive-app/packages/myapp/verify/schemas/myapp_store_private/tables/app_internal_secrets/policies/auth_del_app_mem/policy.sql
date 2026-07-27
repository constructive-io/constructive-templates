-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/policies/auth_del_app_mem/policy


SELECT verify_policy('auth_del_app_mem', 'myapp_store_private.app_internal_secrets');


