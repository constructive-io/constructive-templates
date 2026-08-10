-- Verify: schemas/myapp_memberships_public/tables/app_membership_defaults/indexes/app_membership_defaults_updated_at_idx


SELECT assert_index('myapp_memberships_public.app_membership_defaults_updated_at_idx'::regclass, 'myapp_memberships_public.app_membership_defaults'::regclass, false);


