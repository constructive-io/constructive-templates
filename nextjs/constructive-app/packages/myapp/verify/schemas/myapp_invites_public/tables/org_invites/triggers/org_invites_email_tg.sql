-- Verify: schemas/myapp_invites_public/tables/org_invites/triggers/org_invites_email_tg


SELECT assert_trigger('myapp_invites_public.org_invites'::regclass, 'org_invites_email_tg', 'myapp_invites_private.org_invites_insert_before_tg'::regproc, 7);


