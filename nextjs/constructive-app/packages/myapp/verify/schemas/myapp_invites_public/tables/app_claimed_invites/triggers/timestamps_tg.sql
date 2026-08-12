-- Verify: schemas/myapp_invites_public/tables/app_claimed_invites/triggers/timestamps_tg


SELECT assert_trigger('myapp_invites_public.app_claimed_invites'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


