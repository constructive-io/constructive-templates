-- Verify: schemas/myapp_invites_public/tables/app_invites/triggers/app_invites_email_tg


SELECT assert_trigger('myapp_invites_public.app_invites'::regclass, 'app_invites_email_tg', 'myapp_invites_private.app_invites_insert_before_tg'::regproc, 7);


