-- Verify: schemas/myapp_invites_public/tables/app_invites/triggers/app_invites_email_tg_after


SELECT assert_trigger('myapp_invites_public.app_invites'::regclass, 'app_invites_email_tg_after', 'myapp_invites_private.app_invites_insert_after_tg'::regproc, 5);


