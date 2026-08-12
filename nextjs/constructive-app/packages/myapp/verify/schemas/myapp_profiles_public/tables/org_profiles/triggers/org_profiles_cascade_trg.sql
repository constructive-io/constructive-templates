-- Verify: schemas/myapp_profiles_public/tables/org_profiles/triggers/org_profiles_cascade_trg


SELECT assert_trigger('myapp_profiles_public.org_profiles'::regclass, 'org_profiles_cascade_trg', 'myapp_profiles_private.org_profiles_cascade_tg'::regproc, 17);


