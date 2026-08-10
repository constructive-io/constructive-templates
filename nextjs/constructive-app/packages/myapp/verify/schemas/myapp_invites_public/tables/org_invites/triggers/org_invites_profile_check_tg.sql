-- Verify: schemas/myapp_invites_public/tables/org_invites/triggers/org_invites_profile_check_tg


SELECT assert_trigger('myapp_invites_public.org_invites'::regclass, 'org_invites_profile_check_tg', 'myapp_invites_private.org_invites_profile_check_tg'::regproc, 7);


