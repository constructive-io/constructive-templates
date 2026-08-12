-- Verify: schemas/myapp_memberships_public/tables/org_member_profiles/triggers/timestamps_tg


SELECT assert_trigger('myapp_memberships_public.org_member_profiles'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


