-- Verify: schemas/myapp_profiles_public/tables/org_profile_capabilities/indexes/org_profile_capabilities_updated_at_idx


SELECT assert_index('myapp_profiles_public.org_profile_capabilities_updated_at_idx'::regclass, 'myapp_profiles_public.org_profile_capabilities'::regclass, false);


