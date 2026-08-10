-- Verify: schemas/myapp_profiles_public/tables/org_membership_profiles/triggers/timestamps_tg


SELECT assert_trigger('myapp_profiles_public.org_membership_profiles'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


