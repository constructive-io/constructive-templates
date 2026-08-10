-- Verify: schemas/myapp_invites_public/tables/org_invites/triggers/org_invites_email_tg_after


SELECT assert_trigger('myapp_invites_public.org_invites'::regclass, 'org_invites_email_tg_after', 'myapp_invites_private.org_invites_insert_after_tg'::regproc, 5);


