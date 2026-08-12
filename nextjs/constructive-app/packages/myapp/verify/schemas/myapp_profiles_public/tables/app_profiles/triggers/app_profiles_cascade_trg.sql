-- Verify: schemas/myapp_profiles_public/tables/app_profiles/triggers/app_profiles_cascade_trg


SELECT assert_trigger('myapp_profiles_public.app_profiles'::regclass, 'app_profiles_cascade_trg', 'myapp_profiles_private.app_profiles_cascade_tg'::regproc, 17);


