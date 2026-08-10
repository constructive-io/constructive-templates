-- Verify: schemas/myapp_auth_private/tables/auth_user_devices/triggers/timestamps_tg


SELECT assert_trigger('myapp_auth_private.auth_user_devices'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


