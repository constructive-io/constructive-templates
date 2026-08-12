-- Verify: schemas/myapp_profiles_public/tables/org_membership_profiles/triggers/org_membership_profiles_remove_trg


SELECT assert_trigger('myapp_profiles_public.org_membership_profiles'::regclass, 'org_membership_profiles_remove_trg', 'myapp_profiles_private.org_membership_profiles_remove_tg'::regproc, 9);


