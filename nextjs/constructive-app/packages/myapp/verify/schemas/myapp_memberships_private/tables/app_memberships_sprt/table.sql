-- Verify: schemas/myapp_memberships_private/tables/app_memberships_sprt/table


SELECT assert_table('myapp_memberships_private.app_memberships_sprt'::regclass, false, NULL);


