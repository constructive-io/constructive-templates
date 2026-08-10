-- Verify: schemas/myapp_users_public/tables/users/indexes/users_created_at_idx


SELECT assert_index('myapp_users_public.users_created_at_idx'::regclass, 'myapp_users_public.users'::regclass, false);


