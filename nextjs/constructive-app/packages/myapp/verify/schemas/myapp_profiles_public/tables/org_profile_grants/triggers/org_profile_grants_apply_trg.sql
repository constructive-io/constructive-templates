-- Verify: schemas/myapp_profiles_public/tables/org_profile_grants/triggers/org_profile_grants_apply_trg


SELECT assert_trigger('myapp_profiles_public.org_profile_grants'::regclass, 'org_profile_grants_apply_trg', 'myapp_profiles_private.org_profile_grants_apply_tg'::regproc, 5);


