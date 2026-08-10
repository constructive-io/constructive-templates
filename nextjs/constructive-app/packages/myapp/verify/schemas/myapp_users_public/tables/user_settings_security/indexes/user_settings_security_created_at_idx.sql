-- Verify: schemas/myapp_users_public/tables/user_settings_security/indexes/user_settings_security_created_at_idx


SELECT assert_index('myapp_users_public.user_settings_security_created_at_idx'::regclass, 'myapp_users_public.user_settings_security'::regclass, false);


