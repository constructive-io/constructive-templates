-- Verify: schemas/myapp_memberships_private/tables/org_memberships_sprt/table


SELECT assert_table('myapp_memberships_private.org_memberships_sprt'::regclass, false, NULL);


