-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/indexes/org_membership_settings_created_by_idx


SELECT assert_index('myapp_memberships_public.org_membership_settings_created_by_idx'::regclass, 'myapp_memberships_public.org_membership_settings'::regclass, false);


