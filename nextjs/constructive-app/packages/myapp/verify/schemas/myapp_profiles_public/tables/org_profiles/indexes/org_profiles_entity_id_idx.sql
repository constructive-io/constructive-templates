-- Verify: schemas/myapp_profiles_public/tables/org_profiles/indexes/org_profiles_entity_id_idx


SELECT assert_index('myapp_profiles_public.org_profiles_entity_id_idx'::regclass, 'myapp_profiles_public.org_profiles'::regclass, false);


