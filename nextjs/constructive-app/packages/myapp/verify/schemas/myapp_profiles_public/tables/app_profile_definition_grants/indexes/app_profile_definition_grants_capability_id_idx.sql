-- Verify: schemas/myapp_profiles_public/tables/app_profile_definition_grants/indexes/app_profile_definition_grants_capability_id_idx


SELECT assert_index('myapp_profiles_public.app_profile_definition_grants_capability_id_idx'::regclass, 'myapp_profiles_public.app_profile_definition_grants'::regclass, false);


