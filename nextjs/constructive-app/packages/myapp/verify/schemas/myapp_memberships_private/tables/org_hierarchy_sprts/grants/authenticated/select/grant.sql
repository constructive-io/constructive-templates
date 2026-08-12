-- Verify: schemas/myapp_memberships_private/tables/org_hierarchy_sprts/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_memberships_private.org_hierarchy_sprts'::regclass, 'authenticated', 'SELECT', NULL, true);


