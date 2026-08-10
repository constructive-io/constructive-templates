-- Verify: schemas/myapp_limits_public/tables/app_limit_caps_defaults/policies/auth_upd_app_mem/policy


SELECT assert_policy('myapp_limits_public.app_limit_caps_defaults'::regclass, 'auth_upd_app_mem', 'UPDATE', true, true, false);


