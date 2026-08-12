-- Verify: schemas/myapp_profiles_public/tables/app_membership_profiles/triggers/app_membership_profiles_apply_trg


SELECT assert_trigger('myapp_profiles_public.app_membership_profiles'::regclass, 'app_membership_profiles_apply_trg', 'myapp_profiles_private.app_membership_profiles_apply_tg'::regproc, 5);


