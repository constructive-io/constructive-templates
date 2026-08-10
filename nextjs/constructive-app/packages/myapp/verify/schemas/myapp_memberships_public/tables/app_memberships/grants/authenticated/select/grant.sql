-- Verify: schemas/myapp_memberships_public/tables/app_memberships/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.app_memberships'::regclass, 'authenticated', 'SELECT', NULL, true);


