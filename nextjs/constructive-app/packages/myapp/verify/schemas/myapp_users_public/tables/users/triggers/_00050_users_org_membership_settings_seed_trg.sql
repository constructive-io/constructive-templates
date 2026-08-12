-- Verify: schemas/myapp_users_public/tables/users/triggers/_00050_users_org_membership_settings_seed_trg


SELECT assert_trigger('myapp_users_public.users'::regclass, '_00050_users_org_membership_settings_seed_trg', 'myapp_memberships_private.org_membership_settings_seed_fn'::regproc, 5);


