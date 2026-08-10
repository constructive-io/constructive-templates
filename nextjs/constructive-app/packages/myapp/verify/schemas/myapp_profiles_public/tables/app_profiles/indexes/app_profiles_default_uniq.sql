-- Verify: schemas/myapp_profiles_public/tables/app_profiles/indexes/app_profiles_default_uniq


SELECT assert_index('myapp_profiles_public.app_profiles_default_uniq'::regclass, 'myapp_profiles_public.app_profiles'::regclass, true);


