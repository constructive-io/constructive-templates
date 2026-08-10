-- Verify: schemas/myapp_profiles_public/tables/org_membership_profiles/table


SELECT assert_table('myapp_profiles_public.org_membership_profiles'::regclass, false, NULL);


