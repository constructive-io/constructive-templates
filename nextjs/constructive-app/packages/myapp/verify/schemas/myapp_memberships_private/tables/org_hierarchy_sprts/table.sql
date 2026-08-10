-- Verify: schemas/myapp_memberships_private/tables/org_hierarchy_sprts/table


SELECT assert_table('myapp_memberships_private.org_hierarchy_sprts'::regclass, false, NULL);


