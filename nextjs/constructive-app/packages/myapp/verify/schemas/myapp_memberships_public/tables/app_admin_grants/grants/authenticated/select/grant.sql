-- Verify: schemas/myapp_memberships_public/tables/app_admin_grants/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.app_admin_grants'::regclass, 'authenticated', 'SELECT', NULL, true);


