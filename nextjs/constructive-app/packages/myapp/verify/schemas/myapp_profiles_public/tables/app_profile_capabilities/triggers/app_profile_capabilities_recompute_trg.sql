-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/triggers/app_profile_capabilities_recompute_trg


SELECT assert_trigger('myapp_profiles_public.app_profile_capabilities'::regclass, 'app_profile_capabilities_recompute_trg', 'myapp_profiles_private.app_profile_capabilities_recompute_tg'::regproc, 29);


