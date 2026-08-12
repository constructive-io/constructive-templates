-- Verify: schemas/myapp_profiles_public/tables/org_profiles/indexes/org_profiles_updated_at_idx


SELECT assert_index('myapp_profiles_public.org_profiles_updated_at_idx'::regclass, 'myapp_profiles_public.org_profiles'::regclass, false);


