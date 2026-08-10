-- Verify: schemas/myapp_profiles_public/tables/app_profile_capabilities/triggers/timestamps_tg


SELECT assert_trigger('myapp_profiles_public.app_profile_capabilities'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


