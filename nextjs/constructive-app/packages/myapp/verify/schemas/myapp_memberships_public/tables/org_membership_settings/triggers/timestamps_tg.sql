-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_membership_settings'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


