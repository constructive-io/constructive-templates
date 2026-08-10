-- Verify: schemas/myapp_memberships_public/tables/org_memberships/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.org_memberships'::regclass, 'authenticated', 'SELECT', NULL, true);


