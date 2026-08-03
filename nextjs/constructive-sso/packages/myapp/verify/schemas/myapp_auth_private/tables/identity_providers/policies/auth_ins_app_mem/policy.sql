-- Verify: schemas/myapp_auth_private/tables/identity_providers/policies/auth_ins_app_mem/policy


SELECT verify_policy('auth_ins_app_mem', 'myapp_auth_private.identity_providers');


