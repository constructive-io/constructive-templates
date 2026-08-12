-- Verify: schemas/myapp_users_public/tables/users/triggers/_00060_users_org_profile_templates_seed_trg


SELECT assert_trigger('myapp_users_public.users'::regclass, '_00060_users_org_profile_templates_seed_trg', 'myapp_profiles_private.org_profile_templates_seed_fn'::regproc, 5);


