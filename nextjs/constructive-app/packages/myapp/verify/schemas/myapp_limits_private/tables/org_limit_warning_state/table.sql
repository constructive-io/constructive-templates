-- Verify: schemas/myapp_limits_private/tables/org_limit_warning_state/table


SELECT assert_table('myapp_limits_private.org_limit_warning_state'::regclass, false, NULL);


