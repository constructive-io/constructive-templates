-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_store_private.app_internal_secrets'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


