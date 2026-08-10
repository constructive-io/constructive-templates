-- Verify: schemas/myapp_auth_private/tables/auth_rate_limits/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.auth_rate_limits'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


