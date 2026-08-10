-- Verify: schemas/myapp_memberships_public/tables/app_capability_default_grants/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.app_capability_default_grants'::regclass, 'authenticated', 'SELECT', NULL, true);


