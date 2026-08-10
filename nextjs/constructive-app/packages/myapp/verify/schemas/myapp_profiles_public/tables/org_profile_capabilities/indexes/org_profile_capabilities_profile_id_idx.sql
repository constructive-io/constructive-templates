-- Verify: schemas/myapp_profiles_public/tables/org_profile_capabilities/indexes/org_profile_capabilities_profile_id_idx


SELECT assert_index('myapp_profiles_public.org_profile_capabilities_profile_id_idx'::regclass, 'myapp_profiles_public.org_profile_capabilities'::regclass, false);


