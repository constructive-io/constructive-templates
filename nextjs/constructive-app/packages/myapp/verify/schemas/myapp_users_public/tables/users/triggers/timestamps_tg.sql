-- Verify: schemas/myapp_users_public/tables/users/triggers/timestamps_tg


SELECT assert_trigger('myapp_users_public.users'::regclass, 'timestamps_tg', 'stamps.timestamps'::regproc, 23);


