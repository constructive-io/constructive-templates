-- Verify: schemas/myapp_profiles_public/tables/org_profile_templates/indexes/org_profile_templates_default_uniq


SELECT assert_index('myapp_profiles_public.org_profile_templates_default_uniq'::regclass, 'myapp_profiles_public.org_profile_templates'::regclass, true);


