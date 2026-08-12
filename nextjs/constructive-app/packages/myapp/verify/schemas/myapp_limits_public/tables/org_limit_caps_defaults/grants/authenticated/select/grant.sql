-- Verify: schemas/myapp_limits_public/tables/org_limit_caps_defaults/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_limits_public.org_limit_caps_defaults'::regclass, 'authenticated', 'SELECT', NULL, true);


