-- Verify: schemas/myapp_profiles_public/tables/org_membership_profiles/indexes/org_membership_profiles_updated_at_idx


SELECT assert_index('myapp_profiles_public.org_membership_profiles_updated_at_idx'::regclass, 'myapp_profiles_public.org_membership_profiles'::regclass, false);


