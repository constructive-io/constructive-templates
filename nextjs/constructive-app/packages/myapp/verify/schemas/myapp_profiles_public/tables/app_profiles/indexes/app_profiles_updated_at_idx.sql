-- Verify: schemas/myapp_profiles_public/tables/app_profiles/indexes/app_profiles_updated_at_idx


SELECT assert_index('myapp_profiles_public.app_profiles_updated_at_idx'::regclass, 'myapp_profiles_public.app_profiles'::regclass, false);


