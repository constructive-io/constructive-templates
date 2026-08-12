-- Verify: schemas/myapp_profiles_public/tables/app_profile_templates/indexes/app_profile_templates_created_at_idx


SELECT assert_index('myapp_profiles_public.app_profile_templates_created_at_idx'::regclass, 'myapp_profiles_public.app_profile_templates'::regclass, false);


