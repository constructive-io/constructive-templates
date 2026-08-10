-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/indexes/app_profile_capabilities_created_at_idx


SELECT assert_index('myapp_profiles_public.app_profile_capabilities_created_at_idx'::regclass, 'myapp_profiles_public.app_profile_capabilities'::regclass, false);


