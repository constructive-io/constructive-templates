-- Verify: schemas/myapp_auth_private/tables/auth_rate_limits/table


SELECT assert_table('myapp_auth_private.auth_rate_limits'::regclass, false, NULL);


