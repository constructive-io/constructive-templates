-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/triggers/peoplestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_membership_settings'::regclass, 'peoplestamps_tg', 'myapp_memberships_public.org_membership_settings_peoplestamps'::regproc, 23);


