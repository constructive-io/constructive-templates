-- Verify: schemas/myapp_memberships_public/tables/app_memberships/triggers/peoplestamps_tg


SELECT assert_trigger('myapp_memberships_public.app_memberships'::regclass, 'peoplestamps_tg', 'myapp_memberships_public.app_memberships_peoplestamps'::regproc, 23);


