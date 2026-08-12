-- Verify: schemas/myapp_auth_public/procedures/provision_new_user/procedure


SELECT assert_function('myapp_auth_public.provision_new_user(text, text)'::regprocedure, 'uuid'::regtype, false, true, 'VOLATILE');


