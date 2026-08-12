-- Verify: schemas/myapp_profiles_public/tables/app_profile_definition_grants/triggers/app_profile_definition_grants_apply_trg


SELECT assert_trigger('myapp_profiles_public.app_profile_definition_grants'::regclass, 'app_profile_definition_grants_apply_trg', 'myapp_profiles_private.app_profile_definition_grants_apply_tg'::regproc, 5);


