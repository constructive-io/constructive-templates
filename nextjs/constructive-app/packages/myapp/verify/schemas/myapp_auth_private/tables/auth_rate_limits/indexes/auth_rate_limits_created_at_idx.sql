-- Verify: schemas/myapp_auth_private/tables/auth_rate_limits/indexes/auth_rate_limits_created_at_idx


SELECT assert_index('myapp_auth_private.auth_rate_limits_created_at_idx'::regclass, 'myapp_auth_private.auth_rate_limits'::regclass, false);


