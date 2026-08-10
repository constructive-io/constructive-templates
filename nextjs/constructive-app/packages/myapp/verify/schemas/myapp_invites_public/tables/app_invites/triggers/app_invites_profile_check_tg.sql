-- Verify: schemas/myapp_invites_public/tables/app_invites/triggers/app_invites_profile_check_tg


SELECT assert_trigger('myapp_invites_public.app_invites'::regclass, 'app_invites_profile_check_tg', 'myapp_invites_private.app_invites_profile_check_tg'::regproc, 7);


