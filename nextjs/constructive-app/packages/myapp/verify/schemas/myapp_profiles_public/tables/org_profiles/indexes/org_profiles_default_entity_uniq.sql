-- Verify: schemas/myapp_profiles_public/tables/org_profiles/indexes/org_profiles_default_entity_uniq


SELECT assert_index('myapp_profiles_public.org_profiles_default_entity_uniq'::regclass, 'myapp_profiles_public.org_profiles'::regclass, true);


