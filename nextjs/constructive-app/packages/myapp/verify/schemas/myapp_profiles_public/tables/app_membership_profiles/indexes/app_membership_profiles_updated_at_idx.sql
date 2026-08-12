-- Verify: schemas/myapp_profiles_public/tables/app_membership_profiles/indexes/app_membership_profiles_updated_at_idx


SELECT assert_index('myapp_profiles_public.app_membership_profiles_updated_at_idx'::regclass, 'myapp_profiles_public.app_membership_profiles'::regclass, false);


