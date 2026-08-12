-- Verify: schemas/myapp_memberships_public/tables/org_member_profiles/table


SELECT assert_table('myapp_memberships_public.org_member_profiles'::regclass, false, NULL);


