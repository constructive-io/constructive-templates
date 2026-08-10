-- Verify: schemas/myapp_limits_public/tables/org_limit_caps_defaults/policies/auth_ins_app_mem/policy


SELECT assert_policy('myapp_limits_public.org_limit_caps_defaults'::regclass, 'auth_ins_app_mem', 'INSERT', true, false, true);


