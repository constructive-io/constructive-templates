-- Verify: schemas/myapp_memberships_public/tables/org_membership_defaults/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_membership_defaults'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


