-- Verify: schemas/myapp_memberships_public/tables/org_grants/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.org_grants'::regclass, 'authenticated', 'SELECT', NULL, true);


