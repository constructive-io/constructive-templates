-- Verify: schemas/myapp_auth_public/procedures/current_user/procedure


SELECT assert_function('myapp_auth_public."current_user"()'::regprocedure, 'myapp_users_public.users'::regtype, false, false, 'STABLE');


