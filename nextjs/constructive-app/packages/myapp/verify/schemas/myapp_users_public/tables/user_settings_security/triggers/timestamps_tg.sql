-- Verify: schemas/myapp_users_public/tables/user_settings_security/triggers/timestamps_tg


SELECT assert_trigger('myapp_users_public.user_settings_security'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


