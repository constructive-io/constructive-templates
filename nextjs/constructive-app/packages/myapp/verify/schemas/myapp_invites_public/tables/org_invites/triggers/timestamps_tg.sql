-- Verify: schemas/myapp_invites_public/tables/org_invites/triggers/timestamps_tg


SELECT assert_trigger('myapp_invites_public.org_invites'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


