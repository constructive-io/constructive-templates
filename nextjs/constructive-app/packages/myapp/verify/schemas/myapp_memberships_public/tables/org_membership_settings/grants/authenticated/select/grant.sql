-- Verify: schemas/myapp_memberships_public/tables/org_membership_settings/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.org_membership_settings'::regclass, 'authenticated', 'SELECT', NULL, true);


