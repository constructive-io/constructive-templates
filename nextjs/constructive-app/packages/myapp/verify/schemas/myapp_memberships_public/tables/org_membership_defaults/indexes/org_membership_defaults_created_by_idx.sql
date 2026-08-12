-- Verify: schemas/myapp_memberships_public/tables/org_membership_defaults/indexes/org_membership_defaults_created_by_idx


SELECT assert_index('myapp_memberships_public.org_membership_defaults_created_by_idx'::regclass, 'myapp_memberships_public.org_membership_defaults'::regclass, false);


