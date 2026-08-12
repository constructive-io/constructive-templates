-- Verify: schemas/myapp_profiles_public/tables/org_profile_grants/triggers/timestamps_tg


SELECT assert_trigger('myapp_profiles_public.org_profile_grants'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


