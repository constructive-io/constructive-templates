-- Verify: schemas/myapp_memberships_public/tables/org_membership_defaults/triggers/peoplestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_membership_defaults'::regclass, 'peoplestamps_tg', 'myapp_memberships_public.org_membership_defaults_peoplestamps'::regproc, 23);


