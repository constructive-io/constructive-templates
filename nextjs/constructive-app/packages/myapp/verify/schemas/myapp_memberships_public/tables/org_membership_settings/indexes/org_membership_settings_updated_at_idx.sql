-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/indexes/org_membership_settings_updated_at_idx


SELECT assert_index('myapp_memberships_public.org_membership_settings_updated_at_idx'::regclass, 'myapp_memberships_public.org_membership_settings'::regclass, false);


