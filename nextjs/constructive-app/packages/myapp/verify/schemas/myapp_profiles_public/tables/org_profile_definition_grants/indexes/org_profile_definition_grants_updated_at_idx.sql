-- Verify: schemas/myapp_profiles_public/tables/org_profile_definition_grants/indexes/org_profile_definition_grants_updated_at_idx


SELECT assert_index('myapp_profiles_public.org_profile_definition_grants_updated_at_idx'::regclass, 'myapp_profiles_public.org_profile_definition_grants'::regclass, false);


