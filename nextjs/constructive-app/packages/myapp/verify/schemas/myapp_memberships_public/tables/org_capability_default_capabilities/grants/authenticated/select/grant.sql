-- Verify: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_public.org_capability_default_capabilities'::regclass, 'authenticated', 'SELECT', NULL, true);


