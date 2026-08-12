-- Verify: schemas/myapp_limits_private/tables/app_limit_warning_state/table


SELECT assert_table('myapp_limits_private.app_limit_warning_state'::regclass, false, NULL);


