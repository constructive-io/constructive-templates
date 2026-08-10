-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/table


SELECT assert_table('myapp_memberships_public.org_membership_settings'::regclass, false, NULL);


