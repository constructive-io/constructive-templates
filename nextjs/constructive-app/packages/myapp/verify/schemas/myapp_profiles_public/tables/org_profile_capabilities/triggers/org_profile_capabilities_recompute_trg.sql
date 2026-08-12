-- Verify: schemas/myapp_profiles_public/tables/org_profile_capabilities/triggers/org_profile_capabilities_recompute_trg


SELECT assert_trigger('myapp_profiles_public.org_profile_capabilities'::regclass, 'org_profile_capabilities_recompute_trg', 'myapp_profiles_private.org_profile_capabilities_recompute_tg'::regproc, 29);


