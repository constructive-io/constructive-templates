-- Verify: schemas/myapp_limits_public/tables/org_limit_caps_defaults/table


SELECT assert_table('myapp_limits_public.org_limit_caps_defaults'::regclass, false, NULL);


