-- Verify: schemas/myapp_auth_private/tables/auth_ip_rate_limits/indexes/auth_ip_rate_limits_ip_address_idx


SELECT assert_index('myapp_auth_private.auth_ip_rate_limits_ip_address_idx'::regclass, 'myapp_auth_private.auth_ip_rate_limits'::regclass, false);


