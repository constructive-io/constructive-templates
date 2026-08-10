-- Verify: schemas/myapp_limits_public/tables/org_limit_caps_defaults/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_limits_public.org_limit_caps_defaults'::regclass, 'authenticated', 'UPDATE', NULL, true);


