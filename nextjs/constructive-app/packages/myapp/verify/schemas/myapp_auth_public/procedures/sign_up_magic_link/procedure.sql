-- Verify: schemas/myapp_auth_public/procedures/sign_up_magic_link/procedure


SELECT assert_function('myapp_auth_public.sign_up_magic_link(text, text, boolean, text)'::regprocedure, 'record'::regtype, false, true, 'VOLATILE');


