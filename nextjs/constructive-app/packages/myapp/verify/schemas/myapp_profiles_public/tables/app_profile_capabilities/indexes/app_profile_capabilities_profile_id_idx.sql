-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/indexes/app_profile_capabilities_profile_id_idx


SELECT assert_index('myapp_profiles_public.app_profile_capabilities_profile_id_idx'::regclass, 'myapp_profiles_public.app_profile_capabilities'::regclass, false);


