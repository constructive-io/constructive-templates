-- Verify: schemas/myapp_profiles_public/tables/app_profile_templates/indexes/app_profile_templates_is_default_idx


SELECT assert_index('myapp_profiles_public.app_profile_templates_is_default_idx'::regclass, 'myapp_profiles_public.app_profile_templates'::regclass, false);


