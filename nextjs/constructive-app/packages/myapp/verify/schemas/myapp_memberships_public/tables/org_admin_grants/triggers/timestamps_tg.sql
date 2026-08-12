-- Verify: schemas/myapp_memberships_public/tables/org_admin_grants/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_admin_grants'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


