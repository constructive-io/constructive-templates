-- Verify: schemas/myapp_profiles_public/tables/org_profile_grants/indexes/org_profile_grants_profile_id_idx


SELECT assert_index('myapp_profiles_public.org_profile_grants_profile_id_idx'::regclass, 'myapp_profiles_public.org_profile_grants'::regclass, false);


