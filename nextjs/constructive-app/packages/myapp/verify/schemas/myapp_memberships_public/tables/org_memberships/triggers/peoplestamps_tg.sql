-- Verify: schemas/myapp_memberships_public/tables/org_memberships/triggers/peoplestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_memberships'::regclass, 'peoplestamps_tg', 'myapp_memberships_public.org_memberships_peoplestamps'::regproc, 23);


