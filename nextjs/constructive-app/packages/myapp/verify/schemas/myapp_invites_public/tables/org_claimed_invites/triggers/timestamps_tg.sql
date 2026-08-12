-- Verify: schemas/myapp_invites_public/tables/org_claimed_invites/triggers/timestamps_tg


SELECT assert_trigger('myapp_invites_public.org_claimed_invites'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


