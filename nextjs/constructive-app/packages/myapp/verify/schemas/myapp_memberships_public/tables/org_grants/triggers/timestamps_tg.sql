-- Verify: schemas/myapp_memberships_public/tables/org_grants/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_grants'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


