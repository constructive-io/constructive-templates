-- Verify: schemas/myapp_profiles_public/tables/app_profile_templates/indexes/app_profile_templates_default_uniq


SELECT assert_index('myapp_profiles_public.app_profile_templates_default_uniq'::regclass, 'myapp_profiles_public.app_profile_templates'::regclass, true);


