-- Verify: schemas/myapp_memberships_public/tables/app_owner_grants/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.app_owner_grants'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


