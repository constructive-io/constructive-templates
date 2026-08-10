-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.app_membership_defaults'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


